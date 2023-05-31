import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? fullName;
  final String email;
  final String password;

  const UserEntity({
    
    required this.email,
    required this.password,
    this.fullName,
  });

  @override
  List<Object?> get props => [
        fullName,
      ];
}
