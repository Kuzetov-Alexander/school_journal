part of 'scores_page_bloc.dart';

abstract class ScoresPageState extends Equatable {
  const ScoresPageState();

  @override
  List<Object> get props => [];
}

class ScoresPageInitial extends ScoresPageState {}

class AddedNewStudent extends ScoresPageState {}
