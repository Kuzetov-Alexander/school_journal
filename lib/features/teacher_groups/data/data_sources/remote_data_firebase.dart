import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class RemoteDataFirebase {
  Future<void> createGroup({required String groupName});
  Future<void> readGroup();
  Future<void> removeGroup({required String keyGroup}) async {}
  Future<void> updateGroup();
}

class RemoteDataFirebaseImpl implements RemoteDataFirebase {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  @override
  Future<void> createGroup({required String groupName}) async {
    final dataBase =
        FirebaseDatabase.instance.ref().child('Users/$userId/Groups');

    final postData = {
      groupName: {
        'GroupName': groupName,
        'amountStudents': '0',
        'nextLesson': 'нет',
        'allStudents': 'пусто',
        'allSubject': 'пусто'
      }
    };

    dataBase.update(postData);
  }

  @override
  Future<void> readGroup() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroup() {
    throw UnimplementedError();
  }

  @override
  Future<void> removeGroup({required String keyGroup}) async {
    final dataBase = FirebaseDatabase.instance.ref().child(keyGroup);

    dataBase.remove();
  }
}
// class RemoteDataSourceImpl implements RemoteDataSource {
//   final firebaseAuth = FirebaseAuth.instance;

//   /// Зарегистрироваться
//   @override
//   Future<void> signUp({
//     required String email,
//     required String password,
//     required String fullName,
//   }) async {
//     try {
//       final resultSignUp = await firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       resultSignUp.user?.updateDisplayName(fullName);
//     } on FirebaseAuthException catch (error) {
//       if (error.code == 'weak-password') {
//         throw Exception('The password provided is too weak.');
//       } else if (error.code == 'email-already-in-use') {
//         throw Exception('The account already exists for that email.');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }