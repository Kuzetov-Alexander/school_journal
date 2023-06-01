import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, void>> addLesson({required ScheduleEntity request});
  Future<Either<Failure, List<String>>> downloadGroupName();
  Future<Either<Failure, List<dynamic>>> downloadSubjectName(
      {required String selectedGroup});
}
