part of 'scores_page_bloc.dart';

abstract class ScoresPageState extends Equatable {
  const ScoresPageState();

  @override
  List<Object> get props => [];
}

class GetSnapshotState extends ScoresPageState {
  final Map data;
  const GetSnapshotState({required this.data});
  @override
  List<Object> get props => [data];
}

class DeleteStudent extends ScoresPageState {}

class ScoresPageInitial extends ScoresPageState {}

class AddedNewStudentState extends ScoresPageState {}

class EditScoreState extends ScoresPageState {}

class GetInfoScheduleState extends ScoresPageState {
  final Map<Object?, Object?> data;

  const GetInfoScheduleState({required this.data});
}
