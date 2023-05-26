import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_teacher_groups_event.dart';
part 'bloc_teacher_groups_state.dart';

class BlocTeacherGroupsBloc
    extends Bloc<BlocTeacherGroupsEvent, BlocTeacherGroupsState> {
  // final CreateGroupRepository repository;

  final dataBase = FirebaseDatabase.instance.ref();
  final userId = FirebaseAuth.instance.currentUser?.uid;

  BlocTeacherGroupsBloc() : super(NoGroupsState()) {
// Добавляем урок в общее расписание
    on<AddLessonEvent>((event, emit) async {
      emit(AddedLessonState());

      final lessonData = {
        event.lessonTimeStart + event.currentDate: {
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

    on<CreateGroupEvent>((event, emit) async {
      final dataBase =
          FirebaseDatabase.instance.ref().child('Users/$userId/Groups');

      emit(IsCreatingGroupState());

      final postData = {
        event.groupName: {
          'GroupName': event.groupName,
          'amountStudents': '0',
          'nextLesson': 'нет',
          'allStudents': 'пусто',
          'allSubject': 'пусто'
        }
      };

      dataBase.update(postData);
      emit(IsCreatedGroupState());

      //

      //
    });

    on<DeleteGroupEvent>((event, emit) {
      final dataBase = FirebaseDatabase.instance.ref().child('${event.key}');

      dataBase.remove();
      emit(UpdateState());
    });

    on<DownloadGroupNameEvent>((event, emit) async {
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

        emit(DownloadGroupNameState(
          allNamesGroup: groupNames,
        ));
      }
    });

    on<DownloadSubjectNameEvent>((event, emit) async {
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

    on<GetAllLessonsEvent>((event, emit) async {
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
      emit(UpdateState());
      emit(GotAllLessons(allLessons: dataList, keyDate: keydata));
    });
  }
}


//  print(data.values.toList().where((e) =>e['Group'] == '2a Class' ).toList()); - для получения расписания в определенной группе


// Первая версия добавления урока

// on<AddLessonEvent>((event, emit) async {
//       emit(AddedLessonState());
//       final dataSnapshot = await dataBase.child('Users/$userId/Groups').once();

//       String? currentGroupKey = dataSnapshot.snapshot.children
//           .firstWhere((e) => e.key == event.groupNameforLesson)
//           .key;

//       final lessonData = {
//         event.lessonTimeStart: {
//           'Subject': event.subject,
//           'LessonRoom': event.lessonRoom,
//           'lessonTimeFinish': event.lessonTimeFinish
//         }
//       };
//       await dataBase
//           .child(
//               'Users/$userId/Groups/$currentGroupKey/Schedule/${event.currentYear}/${event.currentMonth}/${event.currentDay}')
//           .update(lessonData);

//       await dataBase
//           .child('Users/$userId/Groups/$currentGroupKey/allSubject')
//           .update({event.subject: ''});
//     });











  // можно пуш добавить и будет уникальное имя
      // final newPostKey = dataBase.push().key! + event.groupName;

      // final postData = {
      //   'GroupName': event.groupName,
      //   'amountStudents': '0',
      //   'nextLesson': 'нет'
      // };

      // final Map<String, Map> updates = {};
      // updates['/Groups/$newPostKey'] = postData;

      // FirebaseDatabase.instance.ref().update(updates);
//------------------------------------------------------------
      // final dataSnapshot = await dataBase.child(event.groupName).get();
      // if (dataSnapshot.exists) {
      //   final Map<Object?, Object?> data =
      //       dataSnapshot.value as Map<Object?, Object?>;
      //   List newcreatedGroup = data.values.toList();
      //   list.add(newcreatedGroup);
      //   print(list);
      // } else {
      //   print('no data');
      // }

      // state.allCreatedGroup.add(newGroup);

      // emit(IsCreatedGroup(allCreatedGroup: list));

      // } else {
      //   emit(const Error(error: 'Ошибка создания группы'));
      // }

      // final newGroup = await repository.createGroup(groupName: event.groupName);
      // if (newGroup.isRight()) {
      //   emit(IsCreatedGroup());
      // } else {
      //   emit(const Error(error: 'Ошибка создания группы'));
      // }
      // });
    

    // on<DeleteGroup>((event, emit) {
    //   final dataBase = FirebaseDatabase.instance.ref().child('${event.key}');
    //   dataBase.remove();
    // });

    // on<DownloadNameGroupsEvent>((event, emit) async {
    //   final dataSnapshot =
    //       await FirebaseDatabase.instance.ref().child('Groups').get();

    //   if (dataSnapshot.exists) {
    //     final Map<Object?, Object?> data =
    //         dataSnapshot.value as Map<Object?, Object?>;

    //     final List<String> groupNames =
    //         []; // Здесь будут храниться все значения ключа "GroupName"
    //     final List<dynamic> dataList = data.values.toList();

    //     for (final dynamic element in dataList) {
    //       if (element is Map<dynamic, dynamic>) {
    //         final String? groupName = element['GroupName'] as String?;
    //         if (groupName != null) {
    //           groupNames.add(groupName);
    //         }
    //       }
    //     }

    //     emit(DownloadNameGroupsState(allNamesGroup: groupNames));
    //   } else {
    //     print('no data');
    //   }
    // });
  
      // });
