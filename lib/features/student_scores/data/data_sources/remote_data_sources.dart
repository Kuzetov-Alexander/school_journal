import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';

abstract class RemoteDataScores {
  Future<void> addStudent({required EntityStudentScores request});

  Future<List<String>> getAllStudent({required EntityStudentScores request});

  Future<void> editScore({required EntityStudentScores request});

  Future<Map<Object?, Object?>> getInfoSubject(
      {required EntityStudentScores request});

  Future<Map<Object?, Object?>> getInfoSchedule();

  Future<void> deleteStudent({required EntityStudentScores request});
}

class RemoteDataScoresImpl implements RemoteDataScores {
  @override
  Future<void> addStudent({required EntityStudentScores request}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Groups/${request.groupName}/allStudents');

    final addData = {
      '${request.fullName}': {
        'FullName': '${request.fullName}',
        'email': request.email,
      }
    };
    await dataBase.update(addData);
  }

  @override
  Future<List<String>> getAllStudent(
      {required EntityStudentScores request}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Groups/${request.groupName}/allStudents');

    final dataSnapshot = await dataBase.get();
    final List<String> resultDataName = [];
    if (dataSnapshot.exists) {
      final Map<Object?, Object?> data =
          dataSnapshot.value as Map<Object?, Object?>;
      final List<dynamic> dataList = data.values.toList();
      for (final dynamic element in dataList) {
        if (element is Map<dynamic, dynamic>) {
          final String? groupName = element['FullName'] as String?;
          if (groupName != null) {
            resultDataName.add(groupName);
          }
        }
      }
      return resultDataName;
    } else {
      return [];
    }
  }

  @override
  Future<void> editScore({required EntityStudentScores request}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase = FirebaseDatabase.instance.ref().child(
        'Users/$userId/Groups/${request.groupName}/allSubject/${request.subject}/Students/${request.fullName}/${request.currentDay}');
    final addData = {
      'score': request.score,
      'visit': 'пусто',
    };
    await dataBase.update(addData);
  }

  @override
  Future<Map<Object?, Object?>> getInfoSubject(
      {required EntityStudentScores request}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase = FirebaseDatabase.instance.ref().child(
        'Users/$userId/Groups/${request.groupName}/allSubject/${request.subject}/Students');

    final dataSnapshot = await dataBase.get();
    // final Map<Object?, Object?> result = {};
    if (dataSnapshot.exists) {
      final Map<Object?, Object?> data =
          dataSnapshot.value as Map<Object?, Object?>;
      return data;
    } else {
      return {};
    }
  }

  @override
  Future<Map<Object?, Object?>> getInfoSchedule() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase =
        FirebaseDatabase.instance.ref().child('Users/$userId/Schedule');

    final dataSnapshot = await dataBase.get();
    // final Map<Object?, Object?> result = {};
    // print(dataSnapshot.value);
    if (dataSnapshot.exists) {
      final Map<Object?, Object?> data =
          dataSnapshot.value as Map<Object?, Object?>;

      return data;
    } else {
      return {};
    }
  }

  @override
  Future<void> deleteStudent({required EntityStudentScores request}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBaseStudent = FirebaseDatabase.instance.ref().child(
        'Users/$userId/Groups/${request.groupName}/allStudents/${request.fullName}');
    ;

    final dataBaseSubject = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Groups/${request.groupName}/allSubject/');
    // .orderByChild('allSubject')
    // .equalTo('${request.fullName}');

    // final snapshot = await dataBaseSubject.once();
    // print(snapshot.snapshot.value);

    // await dataBaseStudent.remove();
  }
}
