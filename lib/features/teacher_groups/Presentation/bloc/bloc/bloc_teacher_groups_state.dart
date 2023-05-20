part of 'bloc_teacher_groups_bloc.dart';

abstract class BlocTeacherGroupsState extends Equatable {
  const BlocTeacherGroupsState();

  @override
  List<Object> get props => [];
}

class IsCreatingGroupState extends BlocTeacherGroupsState {
  @override
  List<Object> get props => [];
}

class IsCreatedGroupState extends BlocTeacherGroupsState {
  // final List<List<Object?>> allCreatedGroup;

  // const IsCreatedGroup({required this.allCreatedGroup});

  // @override
  // List<Object> get props => [allCreatedGroup];
}

class NoGroupsState extends BlocTeacherGroupsState {
  @override
  List<Object> get props => [];
}

class UpdateState extends BlocTeacherGroupsState {
  
}

class DownloadNameGroupsState extends BlocTeacherGroupsState {
  final List<String> allNamesGroup;

  const DownloadNameGroupsState( this.allNamesGroup);
  @override
  List<Object> get props => [];
}


class AddedLessonState extends BlocTeacherGroupsState {
  
  @override
  List<Object> get props => [];
}


class DatabaseErrorState extends BlocTeacherGroupsState {
  final String error;

  const DatabaseErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
