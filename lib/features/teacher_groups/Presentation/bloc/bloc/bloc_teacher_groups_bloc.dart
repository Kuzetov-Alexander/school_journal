import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_teacher_groups_event.dart';
part 'bloc_teacher_groups_state.dart';

class BlocTeacherGroupsBloc
    extends Bloc<BlocTeacherGroupsEvent, BlocTeacherGroupsState> {
  // List<String> list = [];

  // final CreateGroupRepository repository;

  BlocTeacherGroupsBloc() : super(NoGroups()) {
    on<CreateGroup>((event, emit) async {
      final dataBase = FirebaseDatabase.instance.ref().child('Groups');

      emit(IsCreatingGroup());
      //можно пуш добавить и будет уникальное имя
      final newPostKey = dataBase.push().key;

      final postData = {
        'GroupName': event.groupName,
        'amountStudents': '0',
        'nextLesson': 'нет'
      };

      final Map<String, Map> updates = {};
      updates['/Groups/$newPostKey'] = postData;

      FirebaseDatabase.instance.ref().update(updates);

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
    });

    on<DeleteGroup>((event, emit) {
      final dataBase =
          FirebaseDatabase.instance.ref().child('Groups/${event.key}');
      dataBase.remove();
    });

    on<DownloadNameGroupsEvent>((event, emit) async {
      final dataSnapshot =
          await FirebaseDatabase.instance.ref().child('Groups').get();

      if (dataSnapshot.exists) {
        final Map<Object?, Object?> data =
            dataSnapshot.value as Map<Object?, Object?>;

        final List<String> groupNames =
            []; // Здесь будут храниться все значения ключа "GroupName"
        final List<dynamic> dataList = data.values.toList();

        for (final dynamic element in dataList) {
          if (element is Map<dynamic, dynamic>) {
            final String? groupName = element["GroupName"] as String?;
            if (groupName != null) {
              groupNames.add(groupName);
            }
          }
        }

        // print(groupNames);
        // list = groupNames;

        emit(DownloadNameGroupsState(allNamesGroup: groupNames));
      } else {
        print('no data');
      }
    });
  }
}
