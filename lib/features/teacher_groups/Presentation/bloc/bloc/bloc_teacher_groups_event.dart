// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc_teacher_groups_bloc.dart';

abstract class BlocTeacherGroupsEvent extends Equatable {
  const BlocTeacherGroupsEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupEvent extends BlocTeacherGroupsEvent {
  final String groupName;
  const CreateGroupEvent({required this.groupName});
}

class DeleteGroupEvent extends BlocTeacherGroupsEvent {
  final String key;
  const DeleteGroupEvent({required this.key});
}

class DownloadGroupNameEvent extends BlocTeacherGroupsEvent {}

class DownloadSubjectNameEvent extends BlocTeacherGroupsEvent {
  final String selectedGroup;

  const DownloadSubjectNameEvent({required this.selectedGroup});
}

class DownloadRoomNameEvent extends BlocTeacherGroupsEvent {
  final String selectedGroup;

  const DownloadRoomNameEvent({required this.selectedGroup});
}

class AddLessonEvent extends BlocTeacherGroupsEvent {
  final String groupNameforLesson;
  final String subject;
  final String lessonRoom;
  final String lessonTimeStart;
  final String lessonTimeFinish;
  final String currentDate;

  const AddLessonEvent(
      {required this.subject,
      required this.currentDate,
      required this.lessonRoom,
      required this.lessonTimeStart,
      required this.lessonTimeFinish,
      required this.groupNameforLesson});
}
