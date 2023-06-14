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
        final resultRequestBloc = await repository.getAllStudent(
          request: EntityStudentScores(
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

    on<GetInfoSubjectEvent>(
      (event, emit) async {
        final resultRequestBloc = await repository.getInfoSubject(
            request: EntityStudentScores(
          groupName: event.groupName,
          subject: event.subject,
        ));
        if (resultRequestBloc.isRight()) {
          emit(
            GetInfoSubjectState(
              data: resultRequestBloc.getOrElse(() => {}),
            ),
          );
        }
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
  }
}
