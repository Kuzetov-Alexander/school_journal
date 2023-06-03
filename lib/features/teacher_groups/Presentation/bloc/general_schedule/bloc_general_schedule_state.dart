part of 'bloc_general_schedule_bloc.dart';

abstract class BlocGeneralScheduleState extends Equatable {
  const BlocGeneralScheduleState();

  @override
  List<Object> get props => [];
}

class NoGroupsState extends BlocGeneralScheduleState {
  @override
  List<Object> get props => [];
}

class UpdateState extends BlocGeneralScheduleState {
  final String selectedDate;
  final String lessonTimeStart;
  final String room;
  final String lessonTimeFinish;
  const UpdateState(
      {this.room = '',
      this.lessonTimeFinish = '',
      this.selectedDate = '',
      required this.lessonTimeStart});

  @override
  List<Object> get props => [
        selectedDate,
        lessonTimeStart,
        lessonTimeFinish,
        room,
      ];
}

class DownloadGroupNameState extends BlocGeneralScheduleState {
  final List<String> allNamesGroup;

  const DownloadGroupNameState({
    required this.allNamesGroup,
  });
  @override
  List<Object> get props => [allNamesGroup];
}

class DownloadSubjectNameState extends BlocGeneralScheduleState {
  final List<dynamic> allSubjectGroup;

  const DownloadSubjectNameState({
    required this.allSubjectGroup,
  });
  @override
  List<Object> get props => [allSubjectGroup];
}

class AddedLessonState extends BlocGeneralScheduleState {
  @override
  List<Object> get props => [];
}

class GotAllLessonsState extends BlocGeneralScheduleState {
  final List allLessons;
  final String keyDate;
  const GotAllLessonsState({required this.allLessons, required this.keyDate});

  @override
  List<Object> get props => [allLessons, keyDate];
}

class GotCurrentLessonsState extends BlocGeneralScheduleState {
  final List lessons;
  final String keyDate;
  const GotCurrentLessonsState({required this.lessons, required this.keyDate});

  @override
  List<Object> get props => [lessons, keyDate];
}

class DatabaseErrorState extends BlocGeneralScheduleState {
  final String error;

  const DatabaseErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
