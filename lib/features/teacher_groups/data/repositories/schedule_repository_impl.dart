import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/teacher_groups/data/data_sources/remote_data_firebase.dart';
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';

import 'package:school_journal/features/teacher_groups/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RemoteDataFirebase dataBase;

  ScheduleRepositoryImpl({
    required this.dataBase,
  });

  @override
  Future<Either<Failure, void>> addLesson(
      {required ScheduleEntity request}) async {
    try {
      return await dataBase
          .addLesson(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> downloadGroupName() async {
    try {
      return await dataBase.downloadGroupName().then(
            (value) => Right(value),
          );
    } on Object {
      return Left<Failure, List<String>>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> downloadSubjectName(
      {required String selectedGroup}) async {
    try {
      return await dataBase
          .downloadSubjectName(selectedGroup: selectedGroup)
          .then(
            (value) => Right(value),
          );
    } on Object {
      return Left<Failure, List<dynamic>>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getAllLessons(
      {required List<dynamic> dataList, required String selectedDate}) async {
    try {
      return await dataBase
          .getAllLessons(selectedDate: selectedDate, dataList: dataList)
          .then(
            (value) => Right(value),
          );
    } on Object {
      return Left<Failure, String>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentLessons(
      {required List dataList,
      required String selectedDate,
      required String groupName}) async {
    try {
      return await dataBase
          .getCurrentLessons(
              dataList: dataList,
              selectedDate: selectedDate,
              groupName: groupName)
          .then(
            (value) => Right(value),
          );
    } on Object {
      return Left<Failure, String>(DataBaseFailure());
    }
  }
}
