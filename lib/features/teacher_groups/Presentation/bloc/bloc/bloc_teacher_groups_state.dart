part of 'bloc_teacher_groups_bloc.dart';

abstract class BlocTeacherGroupsState extends Equatable {
  const BlocTeacherGroupsState();

  @override
  List<Object> get props => [];
}

class IsCreatingGroup extends BlocTeacherGroupsState {
  @override
  List<Object> get props => [];
}

class IsCreatedGroup extends BlocTeacherGroupsState {
  final List<List<Object?>> allCreatedGroup;

  const IsCreatedGroup({required this.allCreatedGroup});

  @override
  List<Object> get props => [allCreatedGroup];
}

class NoGroups extends BlocTeacherGroupsState {
  @override
  List<Object> get props => [];
}

class DownloadNameGroupsState extends BlocTeacherGroupsState {
  final List<String> allNamesGroup;

  const DownloadNameGroupsState({required this.allNamesGroup});
  @override
  List<Object> get props => [];
}

class DatabaseError extends BlocTeacherGroupsState {
  final String error;

  const DatabaseError({required this.error});

  @override
  List<Object> get props => [error];
}
