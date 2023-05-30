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

class UpdateState extends BlocGeneralScheduleState {}

class DownloadGroupNameState extends BlocGeneralScheduleState {
  final List<String> allNamesGroup;

  const DownloadGroupNameState({
    required this.allNamesGroup,
  });
  @override
  List<Object> get props => [];
}

class DownloadSubjectNameState extends BlocGeneralScheduleState {
  final List<dynamic> allSubjectGroup;

  const DownloadSubjectNameState({
    required this.allSubjectGroup,
  });
  @override
  List<Object> get props => [];
}

class AddedLessonState extends BlocGeneralScheduleState {
  @override
  List<Object> get props => [];
}

class GotAllLessons extends BlocGeneralScheduleState {
 final List allLessons;
  final String keyDate;
   const GotAllLessons({required this.allLessons, required this.keyDate});

  @override
  List<Object> get props => [];
}

class GotCurrentLessonsState extends BlocGeneralScheduleState {
 final List lessons;
 final String keyDate;
 const GotCurrentLessonsState({required this.lessons, required this.keyDate});

  @override
  List<Object> get props => [];
}

class DatabaseErrorState extends BlocGeneralScheduleState {
  final String error;

  const DatabaseErrorState({required this.error});

  @override
  List<Object> get props => [error];
}