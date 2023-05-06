import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';


part 'bloc_teacher_groups_event.dart';
part 'bloc_teacher_groups_state.dart';


class BlocTeacherGroupsBloc
    extends Bloc<BlocTeacherGroupsEvent, BlocTeacherGroupsState> {
     List <List<Object?>> list =[] ;
  // final CreateGroupRepository repository;
// final groupId = const Uuid().v4(); // для генерации уникального номера группы
  BlocTeacherGroupsBloc() : super(NoGroups()) {
    on<CreateGroup>((event, emit) async {
      
      final dataBase = FirebaseDatabase.instance.ref().child('Groups');

      emit(IsCreatingGroup());
      await dataBase.update({
     event.groupName: {
      'GroupName': event.groupName,
        'amountStudents': '0',
        'nextLesson': 'нет'}
      });
    
    final dataSnapshot = await dataBase.child(event.groupName).get();
if (dataSnapshot.exists) {
  final Map<Object?, Object?> data = dataSnapshot.value as Map <Object?,Object?>;
 List newcreatedGroup= data.values.toList();
 list.add(newcreatedGroup); 
print(list);
 
} else {
  print('no data');

}




      // state.allCreatedGroup.add(newGroup);

      emit(IsCreatedGroup(allCreatedGroup: list));
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


    



  }
}
