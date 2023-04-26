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

  SignUpRequested(this.email, this.password);
}

class GoogleSignInRequested extends BlocAuthEvent {}

class SignOutRequested extends BlocAuthEvent {}
