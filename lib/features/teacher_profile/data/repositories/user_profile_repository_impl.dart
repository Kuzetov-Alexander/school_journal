import 'package:school_journal/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:school_journal/features/teacher_profile/data/datasources/remote_data_profile.dart';
import 'package:school_journal/features/teacher_profile/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final RemoteDataProfile dataBase;

  UserProfileRepositoryImpl({required this.dataBase});
  @override
  Future<Either<Failure, void>> downloadGroupName() async {
    try {
      return await dataBase.deleteUserProfile().then((value) => Right(value));
    } on Object {
      return Left<Failure, void>(DataBaseFailure());
    }
  }
}
