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

    on<GetInfoScheduleEvent>((event, emit) async {
      final resultRequestBloc = await repository.getInfoSchedule();
      if (resultRequestBloc.isRight()) {
        emit(
          GetInfoScheduleState(
            data: resultRequestBloc.getOrElse(() => {}),
          ),
        );
      }
    });

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

    on<DeleteStudentEvent>((event, emit) async {
      await repository.deleteStudent(
          request: EntityStudentScores(
              fullName: event.studentName, groupName: event.groupName));
    });

    on<GetSnapshotEvent>(
      (event, emit) async {
        final method = await repository.getSnapshot();
        if (method.isRight()) {
          emit(
            GetSnapshotState(
              data: method.getOrElse(() => {}),
            ),
          );
        }
      },
    );
  }
}
