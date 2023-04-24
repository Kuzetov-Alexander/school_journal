part of 'bloc_auth_bloc.dart';



abstract class BlocAuthState extends Equatable {}

// When the user presses the signin or signup button the state is changed to loading first and then to Authenticated.
class Loading extends BlocAuthState {
  @override
  List<Object?> get props => [];
}

// When the user is authenticated the state is changed to Authenticated.
class Authenticated extends BlocAuthState {
  @override
  List<Object?> get props => [];
}

// This is the initial state of the bloc. When the user is not authenticated the state is changed to Unauthenticated.
class UnAuthenticated extends BlocAuthState {
  @override
  List<Object?> get props => [];
}

// If any error occurs the state is changed to AuthError.
class AuthError extends BlocAuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
