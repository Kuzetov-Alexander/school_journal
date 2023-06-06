import 'package:equatable/equatable.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';
import 'package:school_journal/features/student_scores/domain/repositories/repository_scores.dart';

part 'scores_page_event.dart';
part 'scores_page_state.dart';

class ScoresPageBloc extends Bloc<ScoresPageEvent, ScoresPageState> {
  final RepositoryScores repositoryScores;
  final dataBase = FirebaseDatabase.instance.ref();

  ScoresPageBloc({required this.repositoryScores})
      : super(ScoresPageInitial()) {
    on<AddNewStudentEvent>((event, emit) async {
      repositoryScores.addStudent(
        request: EntityStudentScores(
          fullName: event.studentName,
          groupName: event.groupName,
          email: event.email,
        ),
      );
      emit(AddedNewStudent());
    });
  }
}
