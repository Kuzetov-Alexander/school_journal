import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, void>> addLesson(
      {required String groupNameforLesson,
      required String subject,
      required String lessonRoom,
      required String lessonTimeStart,
      required String lessonTimeFinish,
      required String currentDate});
}
