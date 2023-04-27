import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          print('------------Метод входа пользователья выполнен');
          emit(Authenticated());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('------------Пользователь не найден');
            throw Exception('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('------------Пароль неверен');
            throw Exception('Wrong password provided for that user.');
          }
          emit(AuthError(e.toString()));
          emit(UnAuthenticated());
        }
      },
    );

    //     try {
    //       await authRepository.signIn(
    //           email: event.email, password: event.password);
    //       emit(Authenticated());
    //     } catch (e) {
    //       emit(
    //         AuthError(
    //           e.toString(),
    //         ),
    //       );
    //       emit(UnAuthenticated());
    //     }

    // Когда пользователь нажмет кнопку регистрации,
    // отправится событие SignIрRequested в bloc,
    // чтобы обработать его и передать состоянию, если регистрация выполнена успешно
    on<SignUpRequested>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          await authRepository
              .signUp(email: event.email, password: event.password)
              .then(
            (_) {
              print('------------Регистрация');
              authRepository.sendEmailVerification();
              print('------------Письмо отправлено на почту');
            },
          );
          emit(Authenticated());
        } catch (e) {
          emit(AuthError(e.toString()));
          emit(UnAuthenticated());
        }
      },
    );

    // Когда пользователь нажмет кнопку выйти,
    // отправится событие SignOutRequested в bloc,
    // чтобы обработать его и передать состоянию
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        throw Exception(e);
      }
      emit(UnAuthenticated());
    });
  }
}
