import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';

abstract class RemoteDataScores {
  Future<void> addStudent({required EntityStudentScores request});
}

class RemoteDataScoresImpl implements RemoteDataScores {
  @override
  Future<void> addStudent({required EntityStudentScores request}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Groups/${request.groupName}/allStudents');

    final addData = {
      request.fullName: {
        'FullName': request.fullName,
        'email': request.fullName,
        'Subjects': 'пусто',
      }
    };
    await dataBase.update(addData);
  }
}




    // final allSubjects = await dataBase.child('allSubject').once();
    // late dynamic data;
    // Map<String, Object> studentData = {};

    // if (allSubjects.snapshot.value is String) {
    //   data = allSubjects.snapshot.value as String;
    //   studentData = {
    //     request.fullName: {
    //       'Email': request.email,
    //       'Subjects': '',
    //     }
    //   };
    // } else {
    //   data = allSubjects.snapshot.value as Map<Object?, Object?>;

    //   final List<dynamic> dataList = data.keys.toList();

    //   Map<String?, Object?> mapSubjects = {};
    //   Map generalMap = {
    //     'data': {'grade': '', 'visit': ''}
    //   };

    //   for (var item in dataList) {
    //     mapSubjects[item] = generalMap;
    //   }

    //   studentData = {
    //     request.fullName: {
    //       'Email': request.email,
    //       'Subjects': mapSubjects,
    //     }
    //   };
    // }