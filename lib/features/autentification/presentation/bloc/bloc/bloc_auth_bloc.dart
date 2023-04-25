import 'package:equatable/equatable.dart';
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
          await authRepository.signIn(
              email: event.email, password: event.password);
          emit(Authenticated());
        } catch (e) {
          emit(AuthError(e.toString()));
          emit(UnAuthenticated());
        }
      },
    );

    // Когда пользователь нажмет кнопку регистрации,
    // отправится событие SignIрRequested в bloc,
    // чтобы обработать его и передать состоянию, если регистрация выполнена успешно
    on<SignUpRequested>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          await authRepository.signUp(
              email: event.email, password: event.password);
              // TODO(KUZ): экземпляр класса репозитория объявить
          // await authRepository.sendVerificationEmail();
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
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}

// class AuthRepository {
//   final _firebaseAuth = FirebaseAuth.instance;

//   /// Зарегистрироваться
//   Future<void> signUp({required String email, required String password}) async {
//     try {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         throw Exception('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         throw Exception('The account already exists for that email.');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   /// Выйти
//   Future<void> signOut() async {
//     try {
//       await _firebaseAuth.signOut();
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   /// Войти
//   Future<void> signIn({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         throw Exception('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         throw Exception('Wrong password provided for that user.');
//       }
//     }
//   }

//   Future<void> sendVerificationEmail() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser!;
//       await user.sendEmailVerification();

//       // await Future.delayed(const Duration(seconds: 5));
//     } catch (e) {
//       print('$e');
//     }
//   }
// }
