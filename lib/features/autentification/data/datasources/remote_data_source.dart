import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:school_journal/features/autentification/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

final db = FirebaseDatabase.instance.ref();
final firebaseAuth = FirebaseAuth.instance;

/// Контракт для инициализации, входа, выхода, регистрации в firebase
abstract class RemoteDataSource {
  Future<void> signUp({required UserEntity request});
  Future<void> signIn({required UserEntity request});
  Future<void> signOut();
  Future<void> sendEmailVerification();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  /// Зарегистрироваться
  @override
  Future<void> signUp({required UserEntity request}) async {
    try {
      final resultSignUp = await firebaseAuth.createUserWithEmailAndPassword(
          email: request.email, password: request.password);
      resultSignUp.user?.updateDisplayName(request.fullName);

      final authData = {'name': request.fullName, 'email': request.email};
      final userId = FirebaseAuth.instance.currentUser?.uid;
      await db.child('Users/$userId').update(authData);
      final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
      final sharedPreferences = await prefs;
      sharedPreferences.setString('password', request.password);
      sharedPreferences.setString('email', request.email);
      //privet
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
  Future<void> signIn({required UserEntity request}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: request.email, password: request.password);
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
