import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';

abstract class RemoteDataScores {
  Future<void> addStudent({required EntityStudentScores request});

  Future<void> editScore({required EntityStudentScores request});

  Future<Map<Object?, Object?>> getInfoSchedule();

  Future<void> deleteStudent({required EntityStudentScores request});

  Future<Map> getSnapshot();
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
  Future<Map<Object?, Object?>> getInfoSchedule() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase =
        FirebaseDatabase.instance.ref().child('Users/$userId/Schedule');

    final dataSnapshot = await dataBase.get();
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

    /// лист предметов по for пробегать и каждый предмет вставлять в путь и удалять
    final dataBaseSubject = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Groups/${request.groupName}/allSubject');

    final snapshot = await dataBaseSubject.get();
    Map mapSnapshot = snapshot.value as Map;

    for (String subject in mapSnapshot.keys) {
      final requestStudent = FirebaseDatabase.instance.ref().child(
          'Users/$userId/Groups/${request.groupName}/allSubject/$subject/Students/${request.fullName}');
      final snapshotRequest = await requestStudent.get();
      if (snapshotRequest.value != null) {
        requestStudent.remove();
      }
    }

    await dataBaseStudent.remove();
  }

  @override
  Future<Map> getSnapshot() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase =
        FirebaseDatabase.instance.ref().child('Users/$userId/Groups');
    Map mapData = {};

    final snapshot = await dataBase.get();
    if (snapshot.exists) {
      final snapshotData = snapshot.value as Map;

      mapData.addAll(snapshotData);
      return mapData;
    } else {
      return {};
    }
  }
}
