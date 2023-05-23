import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class RemoteDataFirebase {
  Future<void> createGroup({required String groupName});
  Future<void> readGroup();
  Future<void> deleteGroup({required String keyWidget});
  Future<void> updateGroup();
}

class RemoteDataFirebaseImpl implements RemoteDataFirebase {
  final dataBase = FirebaseDatabase.instance;
  @override
  Future<void> createGroup({required String groupName}) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
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

    final Future<void> newGroup = dataBase.update(postData);
    return newGroup;
  }

  @override
  Future<void> readGroup() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteGroup({required String keyWidget}) async {
    final dataBase = FirebaseDatabase.instance.ref().child(keyWidget);
    dataBase.remove();
  }

  @override
  Future<void> updateGroup() {
    throw UnimplementedError();
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