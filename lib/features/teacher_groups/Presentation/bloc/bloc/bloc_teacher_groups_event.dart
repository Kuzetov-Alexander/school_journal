// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class DeleteGroup extends BlocTeacherGroupsEvent {
  final String? key;
  const DeleteGroup({required this.key});
}

class DownloadNameGroupsEvent extends BlocTeacherGroupsEvent {
 
  // final String? key;
  // const DownloadNameGroups({required this.key});
}

class AddLessonEvent extends BlocTeacherGroupsEvent {
 
final String groupNameforLesson;

  const AddLessonEvent({required this.groupNameforLesson});
}


