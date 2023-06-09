import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';

abstract class RemoteDataScores {
  Future<void> addStudent({required EntityStudentScores request});

  Future<List<String>> getAllStudent({required EntityStudentScores request});

  Future<void> editScore({required EntityStudentScores request});
}

class RemoteDataScoresImpl implements RemoteDataScores {
  @override
  Future<void> addStudent({required EntityStudentScores request}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Groups/${request.groupName}/allStudents');

    // TODO(Sanya) испрвить добавление предметов в студента и придумать как обновлять каждому при добавлении нового предмета
    // final waySubjectsDataBase = FirebaseDatabase.instance
    //     .ref()
    //     .child('Users/$userId/Groups/${request.groupName}/allSubject');
    // final dataSnapshot = await waySubjectsDataBase.once();
    // final dataSubject = dataSnapshot.snapshot.value;
    // final List<dynamic> resultDataGroup = [];
    //  if (dataSubject is Map) {
    //   resultDataGroup.addAll(dataSubject.keys.toList());
    // }

    // ///для отслеживания предметов
    // waySubjectsDataBase.onChildChanged.listen((DatabaseEvent event) {
    //   var dataSubject = event.snapshot.value;
    //   print('onChildChanged ------------------$dataSubject');

    //   if (event.snapshot.value is Map) {
    //     resultDataGroup.addAll(dataSubject);
    //   }
    // });

    final addData = {
      request.fullName: {
        'FullName': request.fullName,
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

    final wayAmountStudentDatabase = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Groups/${request.groupName}/amountStudents');
    final dataSnapshot = await dataBase.get();
    final List<String> resultDataGroup = [];
    if (dataSnapshot.exists) {
      // print(dataSnapshot.value);
      final Map<Object?, Object?> data =
          dataSnapshot.value as Map<Object?, Object?>;
      final List<dynamic> dataList = data.values.toList();
      for (final dynamic element in dataList) {
        if (element is Map<dynamic, dynamic>) {
          final String? groupName = element['FullName'] as String?;
          if (groupName != null) {
            resultDataGroup.add(groupName);
          }
        }
      }
      // подсчет студентов - amountStudent
      await wayAmountStudentDatabase.set(resultDataGroup.length);
      return resultDataGroup;
    } else {
      return [];
    }
  }

  @override
  Future<void> editScore({required EntityStudentScores request}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataBase = FirebaseDatabase.instance.ref().child(
        'Users/$userId/Groups/${request.groupName}/allSubject/${request.subject}/Students/rty');
    final addData = {
      '${request.currentDay}': {
        'score': request.score,
        'visit': 'пусто',
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