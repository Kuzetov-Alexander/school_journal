part of 'scores_page_bloc.dart';

abstract class ScoresPageEvent extends Equatable {
  const ScoresPageEvent();

  @override
  List<Object> get props => [];
}

class GetSnapshotEvent extends ScoresPageEvent {}

class DeleteStudentEvent extends ScoresPageEvent {
  final String groupName;
  final String studentName;

  const DeleteStudentEvent({
    required this.studentName,
    required this.groupName,
  });
}

class AddNewStudentEvent extends ScoresPageEvent {
  final String groupName;
  final String email;
  final String studentName;

  const AddNewStudentEvent(
      {required this.groupName,
      required this.email,
      required this.studentName});
}

class GetInfoScheduleEvent extends ScoresPageEvent {}

class EditScoreEvent extends ScoresPageEvent {
  final String subject;
  final String studentName;
  final String groupName;
  final int score;
  final String currentDay;

  const EditScoreEvent({
    required this.subject,
    required this.studentName,
    required this.groupName,
    required this.score,
    required this.currentDay,
  });
}
