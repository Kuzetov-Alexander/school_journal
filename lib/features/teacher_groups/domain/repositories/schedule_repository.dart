import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, void>> addLesson({
    required ScheduleEntity request,
  });
  Future<Either<Failure, List<String>>> downloadGroupName();
  Future<Either<Failure, List<dynamic>>> downloadSubjectName({
    required String selectedGroup,
  });
  Future<Either<Failure, String>> getAllLessons({
    required List<dynamic> dataList,
    required String selectedDate,
  });
  Future<Either<Failure, String>> getCurrentLessons({
    required List<dynamic> dataList,
    required String selectedDate,
    required String groupName,
  });
}
