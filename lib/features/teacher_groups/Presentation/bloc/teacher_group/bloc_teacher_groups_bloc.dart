import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/teacher_group/bloc_teacher_group_event.dart';
import 'package:school_journal/features/teacher_groups/domain/repositories/create_group_repository.dart';

part 'bloc_teacher_groups_state.dart';

class BlocTeacherGroupsBloc
    extends Bloc<BlocTeacherGroupsEvent, BlocTeacherGroupsState> {
  final CreateGroupRepository repository;

  final dataBase = FirebaseDatabase.instance.ref();
  final userId = FirebaseAuth.instance.currentUser?.uid;

  BlocTeacherGroupsBloc({required this.repository}) : super(InitionalState()) {
    on<CreateGroupEvent>((event, emit) async {
      emit(IsCreatingGroupState());

      repository.createGroup(groupName: event.groupName);

      emit(IsCreatedGroupState());
    });

    on<DeleteGroupEvent>((event, emit) {
     repository.removeGroup(keyGroup: event.key);
      emit(UpdateState());
    });
  }
}


