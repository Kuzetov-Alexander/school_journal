import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, void>> downloadGroupName();
}
