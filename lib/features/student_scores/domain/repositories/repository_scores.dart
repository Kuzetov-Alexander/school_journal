import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';

abstract class RepositoryScores {
  ///Добавление нового студента
  Future<Either<Failure, void>> addStudent(
      {required EntityStudentScores request});

  ///Получение из базы данных лист всех студентов
  Future<Either<Failure, List<String>>> getAllStudent(
      {required EntityStudentScores request});

  Future<Either<Failure, void>> editScore(
      {required EntityStudentScores request});

  //     void _editScore(context,
  //     {required String subject,
  //     required String studentName,
  //     required String score,
  //     required String currentDay}) {
  //   BlocProvider.of<ScoresPageBloc>(context).add(EditScoreEvent(
  //       subject: subject,
  //       studentName: studentName,
  //       score: score,
  //       currentDay: currentDay));
  // }
}
