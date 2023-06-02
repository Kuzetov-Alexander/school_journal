import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RemoteDataProfile {
  Future<void> deleteUserProfile();
}

class RemoteDataProfileImpl implements RemoteDataProfile {
  @override
  Future<void> deleteUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase = FirebaseDatabase.instance.ref();
    final userDB = dataBase.child('Users/$userId');
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final sharedPreferences = await prefs;
    final String passwordUser =
        sharedPreferences.getString('password').toString();
    final String emailUser = sharedPreferences.getString('email').toString();
    final AuthCredential credentials =
        EmailAuthProvider.credential(email: emailUser, password: passwordUser);
    await user?.reauthenticateWithCredential(credentials);
    await userDB.set({});
    await user?.delete();
  }
}
