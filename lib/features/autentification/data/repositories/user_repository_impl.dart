import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/autentification/data/datasources/remote_data_source.dart';
import 'package:school_journal/features/autentification/domain/entities/user_entity.dart';
import 'package:school_journal/features/autentification/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> signUp({required UserEntity request}) async {
    try {
      return await remoteDataSource
          .signUp(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      return await remoteDataSource
          .sendEmailVerification()
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signIn({required UserEntity request}) async {
    try {
      return await remoteDataSource
          .signIn(request: request)
          .then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return await remoteDataSource.signOut().then(
            (value) => Right(value),
          );
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }
}
