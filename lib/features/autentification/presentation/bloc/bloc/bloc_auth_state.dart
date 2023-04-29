part of 'bloc_auth_bloc.dart';

abstract class BlocAuthState extends Equatable {}

class AuthLoading extends BlocAuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends BlocAuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends BlocAuthState {
  @override
  List<Object?> get props => [];
}

class UnEmailVerification extends BlocAuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends BlocAuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
