part of 'scores_page_bloc.dart';

abstract class ScoresPageEvent extends Equatable {
  const ScoresPageEvent();

  @override
  List<Object> get props => [];
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

class GetAllStudentEvent extends ScoresPageEvent {
  final String groupName;

  const GetAllStudentEvent({
    required this.groupName,
  });
}
