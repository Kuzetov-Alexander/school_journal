import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';

abstract class CreateGroupRepository {
  Future<Either<Failure, void>> createGroup({required String groupName});

  Future<Either<Failure, void>> removeGroup({required String keyGroup});
}
