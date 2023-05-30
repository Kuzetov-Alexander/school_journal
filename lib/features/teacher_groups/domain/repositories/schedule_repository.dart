import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';

import 'package:school_journal/features/teacher_groups/domain/requests/schedule_request.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, void>> addLesson({required ScheduleRequest request});
}
