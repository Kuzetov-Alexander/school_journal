import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/student_scores/data/data_sources/remote_data_sources.dart';
import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';

import 'package:school_journal/features/student_scores/domain/repositories/repository_scores.dart';

class RepositoryScoresImpl implements RepositoryScores {
  final RemoteDataScores dataBase;
  RepositoryScoresImpl({required this.dataBase});

  @override
  Future<Either<Failure, void>> addStudent(
      {required EntityStudentScores request}) async {
    try {
      return await dataBase
          .addStudent(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllStudent(
      {required EntityStudentScores request}) async {
    try {
      return await dataBase
          .getAllStudent(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, List<String>>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editScore(
      {required EntityStudentScores request}) async {
    try {
      return await dataBase
          .editScore(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, Map<Object?, Object?>>> getInfoSubject(
      {required EntityStudentScores request}) async {
    try {
      return await dataBase
          .getInfoSubject(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, Map<Object?, Object?>>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, Map<Object?, Object?>>> getInfoSchedule() async {
    try {
      return await dataBase.getInfoSchedule().then((value) => Right(value));
    } on Object {
      return Left<Failure, Map<Object?, Object?>>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(
      {required EntityStudentScores request}) async {
    try {
      return await dataBase
          .deleteStudent(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }
}
