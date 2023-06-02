part of 'bloc_auth_bloc.dart';

abstract class BlocAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequestedEvent extends BlocAuthEvent {
  final String email;
  final String password;

  SignInRequestedEvent(this.email, this.password);
}

class SignUpRequestedEvent extends BlocAuthEvent {
  final String email;
  final String password;
  final String fullName;

  SignUpRequestedEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });
}

class SignOutRequestedEvent extends BlocAuthEvent {}
