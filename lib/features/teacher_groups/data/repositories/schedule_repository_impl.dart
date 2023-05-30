import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/teacher_groups/data/data_sources/remote_data_firebase.dart';

import 'package:school_journal/features/teacher_groups/domain/repositories/schedule_repository.dart';
import 'package:school_journal/features/teacher_groups/domain/requests/schedule_request.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RemoteDataFirebase dataBase;

  ScheduleRepositoryImpl({
    required this.dataBase,
  });

  @override
  Future<Either<Failure, void>> addLesson(
      {required ScheduleRequest request}) async {
    try {
      print('dataRepositoryImpl');
      // final modelasd = model!.toMap();
      // print('mapa : $modelasd');
      return await dataBase
          .addLesson(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }

  // @override
  // Future<Either<Failure, void>> addLesson(
  //     {required String groupNameforLesson,
  //     required String subject,
  //     required String lessonRoom,
  //     required String lessonTimeStart,
  //     required String lessonTimeFinish,
  //     required String currentDate}) async {
  //   try {
  //     print(groupNameforLesson);
  //     print('dataRepositoryImpl');
  //     // final modelasd = model!.toMap();
  //     // print('mapa : $modelasd');
  //     return await dataBase
  //         .addLesson(model)
  //         .then((value) => Right(value));
  //   } on Object {
  //     return Left<Failure, void>(DataBaseFailure());
  //   }
  // }
}
