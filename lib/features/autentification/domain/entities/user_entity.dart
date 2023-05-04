import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String fullName;
  final String email;
  final String password;

  const UserEntity({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        fullName,
      ];
}
