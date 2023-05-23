import 'package:dartz/dartz.dart';

import 'package:school_journal/core/error/failure.dart';
import 'package:school_journal/features/teacher_groups/data/data_sources/remote_data_firebase.dart';
import 'package:school_journal/features/teacher_groups/domain/repositories/create_group_repository.dart';

class CreateGroupRepositoryImpl implements CreateGroupRepository {
  RemoteDataFirebase dataBase;

  CreateGroupRepositoryImpl({required this.dataBase});

  @override
  Future<Either<Failure, void>> createGroup({required String groupName}) async {
    {
      try {
        return await dataBase
            .createGroup(groupName: groupName)
            .then((value) => Right(value));
      } on Object {
        return Left<Failure, void>(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> readGroup() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateGroup() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteGroup({required String keyWidget}) {
    return dataBase
        .deleteGroup(keyWidget: keyWidget)
        .then((value) => Right(value));
  }
}
