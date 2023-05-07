part of 'bloc_teacher_groups_bloc.dart';

abstract class BlocTeacherGroupsEvent extends Equatable {
  const BlocTeacherGroupsEvent();

  @override
  List<Object> get props => [];
}

class CreateGroup extends BlocTeacherGroupsEvent {
  final String groupName;
  const CreateGroup({required this.groupName});
}
