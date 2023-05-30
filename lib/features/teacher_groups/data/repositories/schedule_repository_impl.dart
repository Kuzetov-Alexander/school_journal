import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/teacher_groups/data/data_sources/remote_data_firebase.dart';
import 'package:school_journal/features/teacher_groups/data/model/schedule_model.dart';
import 'package:school_journal/features/teacher_groups/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  RemoteDataFirebase dataBase;
  final ScheduleEntityModel model;

  ScheduleRepositoryImpl({required this.dataBase, this.model});

  @override
  Future<Either<Failure, void>> addLesson(
      {required String groupNameforLesson,
      required String subject,
      required String lessonRoom,
      required String lessonTimeStart,
      required String lessonTimeFinish,
      required String currentDate}) async {
    try {
      print(groupNameforLesson);
      print('dataRepositoryImpl');
      // final modelasd = model!.toMap();
      // print('mapa : $modelasd');
      return await dataBase
          .addLesson(model)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }
}
