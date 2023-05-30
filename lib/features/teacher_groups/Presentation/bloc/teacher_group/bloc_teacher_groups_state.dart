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

}

class DatabaseErrorStat extends BlocTeacherGroupsState {
  final String er;

  const DatabaseErrorStat({required this.er});

  @override
  List<Object> get props => [er];
}


class NoGroupsStat extends BlocTeacherGroupsState {
  @override
  List<Object> get props => [];
}

class UpdateState extends BlocTeacherGroupsState {}



