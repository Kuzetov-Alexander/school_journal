import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:school_journal/features/teacher_groups/domain/requests/schedule_request.dart';

abstract class RemoteDataFirebase {
  Future<void> createGroup({required String groupName});

  Future<void> removeGroup({required String keyGroup});
  Future<void> addLesson({required ScheduleRequest request});
  // {required String groupNameforLesson,
  // required String subject,
  // required String lessonRoom,
  // required String lessonTimeStart,
  // required String lessonTimeFinish,
  // required String currentDate});
}

class RemoteDataFirebaseImpl implements RemoteDataFirebase {
  @override
  Future<void> createGroup({required String groupName}) async {
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

    await dataBase.update(postData);
  }

  @override
  Future<void> removeGroup({required String keyGroup}) async {
    final dataBase = FirebaseDatabase.instance.ref().child(keyGroup);
    await dataBase.remove();
  }

  @override
  Future<void> addLesson({required ScheduleRequest request}) async {
    // final Map<String, Map> lessonData;
    final dataBase = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final lessonData = {
      request.lessonTimeStart: {
        'Subject': request.subject,
        'LessonRoom': request.lessonRoom,
        'lessonTimeStart': request.lessonTimeStart,
        'lessonTimeFinish': request.lessonTimeFinish,
        'groupNameforLesson': request.groupNameforLesson,
        'Homework': 'не задано',
        'StudentAmountatLesson': '0'
      }
    };
    await dataBase
        .child('Users/$userId/Schedule/${request.currentDate}')
        .update(lessonData);

    await dataBase
        .child('Users/$userId/Groups/${request.groupNameforLesson}/allSubject')
        .update({request.subject: ''});
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