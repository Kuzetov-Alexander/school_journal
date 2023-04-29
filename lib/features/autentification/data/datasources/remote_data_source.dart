import 'package:firebase_auth/firebase_auth.dart';

/// Контракт для инициализации, входа, выхода, регистрации в firebase
abstract class RemoteDataSource {
  Future<void> signUp(
      {required String email,
      required String password,
      required String fullName});
  Future<void> signIn({required String email, required String password});
  Future<void> signOut() async {}
  Future<void> sendEmailVerification();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final firebaseAuth = FirebaseAuth.instance;

  /// Зарегистрироваться
  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final resultSignUp = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      resultSignUp.user?.updateDisplayName(fullName);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
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
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (error.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  /// Нужна ли тут обработка ошибок?!
  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = firebaseAuth.currentUser!;
      user.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (error.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  /// Выйти
  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }
}
