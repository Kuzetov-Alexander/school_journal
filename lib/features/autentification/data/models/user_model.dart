import 'package:school_journal/features/autentification/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.fullName,
    required super.email,
    required super.password,
  });
}
