import 'package:firebase_database/firebase_database.dart';

abstract class RemoteDataFirebase {
  Future<void> createGroup({required String groupName});
  Future<void> readGroup();
  Future<void> removeGroup() async {}
  Future<void> updateGroup();
}

class RemoteDataFirebaseImpl implements RemoteDataFirebase {
  final dataBase = FirebaseDatabase.instance;
  @override
  Future<void> createGroup({required String groupName}) {
    final allGroups = dataBase.ref().child('Groups/$groupName');
    final newGroup = allGroups.set({'groupName': groupName});
    return newGroup;
  }

  @override
  Future<void> readGroup() {
    throw UnimplementedError();
  }

  @override
  Future<void> removeGroup() {
    throw UnimplementedError();
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