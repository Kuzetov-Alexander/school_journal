part of 'bloc_auth_bloc.dart';

abstract class BlocAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends BlocAuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends BlocAuthEvent {
  final String email;
  final String password;
  final String fullName;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.fullName,
  });
}

class SignOutRequested extends BlocAuthEvent {}
