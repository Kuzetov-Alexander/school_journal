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
      print('failed addLesson');
      return Left<Failure, void>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> downloadGroupName({required List<String> request}) async {
    try {
      return await dataBase.downloadGroupName(request: request).then(
            (value) => Right(value),
          );
    } on Object {
      print('failed downloadGroupName');
      return Left<Failure, void>(DataBaseFailure());
    }
  }
  
  @override
  Future<Either<Failure, void>> downloadSubjectName({required List<dynamic> request, required String selectedGroup}) async {
    try {
     
      return await dataBase.downloadSubjectName(request: request, selectedGroup: selectedGroup).then(
            (value) => Right(value),
          );
          
    } on Object {
      print('failed downloadSubjectName');
      return Left<Failure, void>(DataBaseFailure());
    }
  }
}
