import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/autentification/data/datasources/remote_data_source.dart';
import 'package:school_journal/features/autentification/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> signIn(
      {required String email, required String password}) async {
    try {
      return await remoteDataSource
          .signIn(email: email, password: password)
          .then(
            (value) => Right(value),
          );
    } on Object {
      return Left<Failure, void>(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> signUp(
      {required String email, required String password}) {
    throw UnimplementedError();
  }
}
