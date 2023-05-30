import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_general_schedule_event.dart';
part 'bloc_general_schedule_state.dart';

class BlocGeneralScheduleBloc
    extends Bloc<BlocGeneralScheduleEvent, BlocGeneralScheduleState> {
  BlocGeneralScheduleBloc() : super(BlocGeneralScheduleInitial()) {
    on<BlocGeneralScheduleEvent>((event, emit) {});

    /// Добавляем урок в общее расписание
    on<AddLessonEvent>((event, emit) async {
      final dataBase = FirebaseDatabase.instance.ref();
      final userId = FirebaseAuth.instance.currentUser?.uid;
      emit(AddedLessonState());

      final lessonData = {
        event.lessonTimeStart: {
          'Subject': event.subject,
          'LessonRoom': event.lessonRoom,
          'lessonTimeStart': event.lessonTimeStart,
          'lessonTimeFinish': event.lessonTimeFinish,
          'Group': event.groupNameforLesson,
          'Homework': 'не задано',
          'StudentAmountatLesson': '0'
        }
      };
      await dataBase
          .child('Users/$userId/Schedule/${event.currentDate}')
          .update(lessonData);

      await dataBase
          .child('Users/$userId/Groups/${event.groupNameforLesson}/allSubject')
          .update({event.subject: ''});
    });

    on<DownloadGroupNameEvent>((event, emit) async {
      final dataBase = FirebaseDatabase.instance.ref();
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final dataSnapshot = await dataBase.child('Users/$userId/Groups').get();

      if (dataSnapshot.exists) {
        final Map<Object?, Object?> data =
            dataSnapshot.value as Map<Object?, Object?>;

        final List<String> groupNames =
            []; // Здесь будут храниться все значения ключа "GroupName"

        final List<dynamic> dataList = data.values.toList();

        for (final dynamic element in dataList) {
          if (element is Map<dynamic, dynamic>) {
            final String? groupName = element['GroupName'] as String?;
            if (groupName != null) {
              groupNames.add(groupName);
            }
          }
        }
        // print(groupNames);
        emit(DownloadGroupNameState(
          allNamesGroup: groupNames,
        ));
      }
    });

    on<DownloadSubjectNameEvent>((event, emit) async {
      final dataBase = FirebaseDatabase.instance.ref();
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final dataShot = await dataBase
          .child('Users/$userId/Groups/${event.selectedGroup}/allSubject')
          .once();

      List<dynamic> subjectNames = [];
      final dataSubject = dataShot.snapshot.value;

      if (dataSubject is Map) {
        subjectNames = dataSubject.keys.toList();
      }

      emit(DownloadSubjectNameState(
        allSubjectGroup: subjectNames,
      ));
    });
  }
}
