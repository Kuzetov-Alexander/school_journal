part of 'scores_page_bloc.dart';

abstract class ScoresPageState extends Equatable {
  const ScoresPageState();

  @override
  List<Object> get props => [];
}

class ScoresPageInitial extends ScoresPageState {}

class AddedNewStudentState extends ScoresPageState {}

class GetAllStudentState extends ScoresPageState {
  final List<String> allStudentData;
  const GetAllStudentState({required this.allStudentData});
  @override
  List<Object> get props => allStudentData;
}

class EditScoreState extends ScoresPageState {}
