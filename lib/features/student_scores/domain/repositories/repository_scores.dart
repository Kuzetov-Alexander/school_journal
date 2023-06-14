import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';

abstract class RepositoryScores {
  /// Добавление нового студента
  Future<Either<Failure, void>> addStudent(
      {required EntityStudentScores request});

  /// Получение из базы данных лист всех студентов
  Future<Either<Failure, List<String>>> getAllStudent(
      {required EntityStudentScores request});

  /// Добавление оценки студенту
  Future<Either<Failure, void>> editScore(
      {required EntityStudentScores request});

  /// Получение из базы данных мапы по предметам
  Future<Either<Failure, Map<Object?, Object?>>> getInfoSubject(
      {required EntityStudentScores request});

  /// Получение из базы данных мапы по расписанию с датами уроков
  Future<Either<Failure, Map<Object?, Object?>>> getInfoSchedule();

  /// Удалить студента
  Future<Either<Failure, void>> deleteStudent(
      {required EntityStudentScores request});
}
