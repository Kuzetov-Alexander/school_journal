import 'package:firebase_auth/firebase_auth.dart';

/// Контракт для инициализации, входа, выхода, регистрации в firebase
abstract class RemoteDataSource {
  Future<void> signUp({required String email, required String password});
  Future<void> signIn({required String email, required String password});
  Future<void> signOut() async {}
  Future<void> sendEmailVerification();
}

/// Класс с реализованными методами инициализации, входа, выхода, регистрации в firebase
class RemoteDataSourceImpl implements RemoteDataSource {
  // TODO(Sanya) Запускаем firebase
  // final _firebaseAuth = FirebaseAuth.instance;

  /// Зарегистрироваться
  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Войти
  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  /// Выйти
  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
