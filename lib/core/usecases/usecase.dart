import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
