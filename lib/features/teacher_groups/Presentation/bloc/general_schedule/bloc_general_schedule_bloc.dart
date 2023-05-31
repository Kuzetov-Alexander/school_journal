import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';
import 'package:school_journal/features/teacher_groups/domain/repositories/schedule_repository.dart';
part 'bloc_general_schedule_event.dart';
part 'bloc_general_schedule_state.dart';

class BlocGeneralScheduleBloc
    extends Bloc<BlocGeneralScheduleEvent, BlocGeneralScheduleState> {
  final ScheduleRepository repository;

  BlocGeneralScheduleBloc({required this.repository}) : super(NoGroupsState()) {
    on<AddLessonEvent>((event, emit) async {
      emit(AddedLessonState());
      repository.addLesson(
        request: ScheduleEntity(
          group: event.groupNameforLesson,
          subject: event.subject,
          lessonRoom: event.lessonRoom,
          lessonTimeStart: event.lessonTimeStart,
          lessonTimeFinish: event.lessonTimeFinish,
          currentDate: event.currentDate,
        ),
      );
    });

    on<DownloadGroupNameEvent>((event, emit) async {
      final stopwatch = Stopwatch();
      stopwatch.start();

      final List<String> groupNames = [];

      await repository.downloadGroupName(request: groupNames);
      emit(DownloadGroupNameState(
        allNamesGroup: groupNames,
      ));
      stopwatch.stop();
      print(stopwatch.elapsedMilliseconds);
      // }
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

    // Получаем уроки для всех групп

    on<GetAllLessonsEvent>((event, emit) async {
      final dataBase = FirebaseDatabase.instance.ref();
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final dataShot = await dataBase
          .child('Users/$userId/Schedule/ ${event.selectedDate}')
          .once();
      List dataList = [];
      String keydata = '';
      if (dataShot.snapshot.value is Map) {
        Map data = dataShot.snapshot.value as Map;
        dataList = data.values.toList();
        keydata = dataShot.snapshot.key.toString();
      }
      // emit(UpdateState());
      emit(GotAllLessonsState(allLessons: dataList, keyDate: keydata));
    });

    // Получаем уроки для определенной группы

    on<GetCurrentLessonsEvent>((event, emit) async {
      final dataBase = FirebaseDatabase.instance.ref();
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final dataShot = await dataBase
          .child('Users/$userId/Schedule/ ${event.selectedDate}')
          .once();
      List dataList = [];
      String keydata = '';
      if (dataShot.snapshot.value is Map) {
        Map data = dataShot.snapshot.value as Map;

        dataList = data.values
            .toList()
            .where((e) => e['Group'] == event.groupName)
            .toList();

        keydata = dataShot.snapshot.key.toString();
      }

      emit(UpdateState());
      emit(GotCurrentLessonsState(lessons: dataList, keyDate: keydata));
    });
  }
}
