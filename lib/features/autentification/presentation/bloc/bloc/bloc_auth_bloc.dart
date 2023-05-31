import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/autentification/domain/entities/user_entity.dart';
import 'package:school_journal/features/autentification/domain/repositories/user_repository.dart';
part 'bloc_auth_event.dart';
part 'bloc_auth_state.dart';

class AuthBloc extends Bloc<BlocAuthEvent, BlocAuthState> {
  final UserRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // Когда пользователь нажмет кнопку входа,
    // отправится событие SignInRequested в bloc,
    // чтобы обработать его и передать состоянии входа,
    // если вход выполнен успешно
    on<SignInRequested>(
      (event, emit) async {
        emit(AuthLoading());
        final authMethod = await authRepository.signIn(
          request: UserEntity(
            email: event.email,
            password: event.password,
          ),
        );
        // email: event.email, password: event.password);
        if (authMethod.isRight()) {
          emit(Authenticated());
        } else {
          emit(AuthError('Произошла ошибка при авторизации'));
          emit(UnAuthenticated());
        }
      },
    );
    // Когда пользователь нажмет кнопку регистрации,
    // отправится событие SignUрRequested в bloc,
    // чтобы обработать его и передать состоянию, если регистрация выполнена успешно
    on<SignUpRequested>(
      (event, emit) async {
        emit(AuthLoading());
        final authMethod = await authRepository.signUp(
          request: UserEntity(
            fullName: event.fullName,
            email: event.email,
            password: event.password,
          ),
        );
        if (authMethod.isRight()) {
          await authRepository.sendEmailVerification();
          // emit(UnEmailVerification());
          emit(Authenticated());
        } else {
          emit(AuthError('Произошла ошибка при регистрации'));
          emit(UnAuthenticated());
        }
      },
    );

    // Когда пользователь нажмет кнопку выйти,
    // отправится событие SignOutRequested в bloc,
    // чтобы обработать его и передать состоянию
    on<SignOutRequested>(
      (event, emit) async {
        emit(AuthLoading());
        final authMethod = await authRepository.signOut();
        if (authMethod.isRight()) {
          emit(UnEmailVerification());
        } else {
          emit(AuthError('Произошла ошибка при выходе из аккаунта'));
          emit(UnEmailVerification());
        }
      },
    );
  }
}
