import 'package:equatable/equatable.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';
import 'package:school_journal/features/student_scores/domain/repositories/repository_scores.dart';

part 'scores_page_event.dart';
part 'scores_page_state.dart';

class ScoresPageBloc extends Bloc<ScoresPageEvent, ScoresPageState> {
  final RepositoryScores repository;
  final dataBase = FirebaseDatabase.instance.ref();

  ScoresPageBloc({required this.repository}) : super(ScoresPageInitial()) {
    on<AddNewStudentEvent>(
      (event, emit) async {
        repository.addStudent(
          request: EntityStudentScores(
            fullName: event.studentName,
            groupName: event.groupName,
            email: event.email,
          ),
        );
        emit(AddedNewStudentState());
      },
    );

    on<GetAllStudentEvent>(
      (event, emit) async {
        // TODO(Sanya) Сущность отредачить!
        final resultRequestBloc = await repository.getAllStudent(
          request: EntityStudentScores(
            fullName: '',
            groupName: event.groupName,
          ),
        );
        if (resultRequestBloc.isRight()) {
          emit(
            GetAllStudentState(
              allStudentData: resultRequestBloc.getOrElse(() => []),
            ),
          );
        }
      },
    );

    on<EditScoreEvent>((event, emit) async {
      await repository.editScore(
          request: EntityStudentScores(
              fullName: event.studentName,
              groupName: event.groupName,
              subject: event.subject,
              score: event.score,
              currentDay: event.currentDay));

      emit(EditScoreState());
    });
  }
}
