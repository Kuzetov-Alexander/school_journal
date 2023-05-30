import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/teacher_group/bloc_teacher_group_event.dart';

part 'bloc_teacher_groups_state.dart';

class BlocTeacherGroupsBloc
    extends Bloc<BlocTeacherGroupsEvent, BlocTeacherGroupsState> {
  // final CreateGroupRepository repository;

  final dataBase = FirebaseDatabase.instance.ref();
  final userId = FirebaseAuth.instance.currentUser?.uid;

  BlocTeacherGroupsBloc() : super(NoGroupsStat()) {
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
    });

    on<DeleteGroupEvent>((event, emit) {
      final dataBase = FirebaseDatabase.instance.ref().child('${event.key}');

      dataBase.remove();
      emit(UpdateState());
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
