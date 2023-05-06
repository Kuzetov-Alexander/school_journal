// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc_teacher_groups_bloc.dart';

abstract class BlocTeacherGroupsState extends Equatable {
  const BlocTeacherGroupsState();

  @override
  List<Object> get props => [];
}

class IsCreatedGroup extends BlocTeacherGroupsState {
  @override
  List<Object> get props => [];
}

class NoGroups extends BlocTeacherGroupsState {
  @override
  List<Object> get props => [];
}

class Error extends BlocTeacherGroupsState {
  final String error;

  const Error({required this.error});

  @override
  List<Object> get props => [error];
}
