class UserEntity {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  UserEntity({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
