part of 'bloc_general_schedule_bloc.dart';

abstract class BlocGeneralScheduleEvent extends Equatable {
  const BlocGeneralScheduleEvent();

  @override
  List<Object> get props => [];
}

class DownloadGroupNameEvent extends BlocGeneralScheduleEvent {}

class DownloadSubjectNameEvent extends BlocGeneralScheduleEvent {
  final String selectedGroup;

  const DownloadSubjectNameEvent({required this.selectedGroup});
}

class GetAllLessonsEvent extends BlocGeneralScheduleEvent {
  final String selectedDate;

  const GetAllLessonsEvent({required this.selectedDate});
  @override
  List<Object> get props => [selectedDate];
}

class GetCurrentLessonsEvent extends BlocGeneralScheduleEvent {
  final String selectedDate;
  final String groupName;

  const GetCurrentLessonsEvent({
    required this.selectedDate,
    required this.groupName,
  });
}

// удаляем урок из расписания 
class DeleteLessonsEvent extends BlocGeneralScheduleEvent {
  final String selectedDate;
  final String lessonTimeStart;

  const DeleteLessonsEvent({
    required this.selectedDate,
    required this.lessonTimeStart,
  });
}

class AddLessonEvent extends BlocGeneralScheduleEvent {
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
