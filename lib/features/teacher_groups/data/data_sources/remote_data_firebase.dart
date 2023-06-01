import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:school_journal/features/teacher_groups/data/model/schedule_model.dart';
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';

abstract class RemoteDataFirebase {
  Future<void> createGroup({required String groupName});
  Future<void> removeGroup({required String keyGroup});
  Future<void> addLesson({required ScheduleEntity request});
  Future<List<String>> downloadGroupName();
  Future<List<dynamic>> downloadSubjectName({required String selectedGroup});
  Future<String> getAllLessons(
      {required List<dynamic> dataList, required String selectedDate});
  Future<String> getCurrentLessons(
      {required List<dynamic> dataList,
      required String selectedDate,
      required String groupName});
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
  Future<void> addLesson({required ScheduleEntity request}) async {
    final dataBase = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final model = ScheduleEntityModel(
            group: request.group,
            subject: request.subject,
            lessonRoom: request.lessonRoom,
            lessonTimeStart: request.lessonTimeStart,
            lessonTimeFinish: request.lessonTimeFinish,
            currentDate: request.currentDate)
        .toMap();

    await dataBase
        .child('Users/$userId/Schedule/${request.currentDate}')
        .update(model);

    await dataBase
        .child('Users/$userId/Groups/${request.group}/allSubject')
        .update({request.subject: ''});
  }

  @override
  Future<List<String>> downloadGroupName() async {
    final dataBase = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final dataSnapshot = await dataBase.child('Users/$userId/Groups').get();
    final List<String> resultDataGroup = [];
    if (dataSnapshot.exists) {
      final Map<Object?, Object?> data =
          dataSnapshot.value as Map<Object?, Object?>;
      final List<dynamic> dataList = data.values.toList();
      //   dataList
      //       .where((element) =>
      //           element is Map<dynamic, dynamic> &&
      //           (element['GroupName'] as String?) != null)
      //       .map((e) {
      //     e['GroupName'] as String;
      //   }).toList();
      //   resultDataGroup.addAll(dataList);
      //   return [...resultDataGroup];
      // } else {
      //   return [];
      // }

      for (final dynamic element in dataList) {
        if (element is Map<dynamic, dynamic>) {
          final String? groupName = element['GroupName'] as String?;
          if (groupName != null) {
            resultDataGroup.add(groupName);
          }
        }
      }
      return resultDataGroup;
    } else {
      return [];
    }
  }

  @override
  Future<List<dynamic>> downloadSubjectName(
      {required String selectedGroup}) async {
    final dataBase = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final dataShot = await dataBase
        .child('Users/$userId/Groups/$selectedGroup/allSubject')
        .once();
    final List<dynamic> dataRequest = [];
    final dataSubject = dataShot.snapshot.value;

    if (dataSubject is Map) {
      dataRequest.addAll(dataSubject.keys.toList());
    }
    return dataRequest;
  }

  @override
  Future<String> getAllLessons(
      {required List<dynamic> dataList, required String selectedDate}) async {
    final dataBase = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataShot =
        await dataBase.child('Users/$userId/Schedule/$selectedDate').once();

    String keydata = '';
    if (dataShot.snapshot.value is Map) {
      Map data = dataShot.snapshot.value as Map;
      dataList.addAll(data.values.toList());
      keydata = dataShot.snapshot.key.toString();
      return keydata;
    } else {
      return '';
    }
  }

  @override
  Future<String> getCurrentLessons(
      {required List dataList,
      required String selectedDate,
      required String groupName}) async {
    final dataBase = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final dataShot =
        await dataBase.child('Users/$userId/Schedule/$selectedDate').once();
    String keydata = '';
    if (dataShot.snapshot.value is Map) {
      Map data = dataShot.snapshot.value as Map;
      final resultData =
          data.values.toList().where((e) => e['Group'] == groupName).toList();

      dataList.addAll(resultData);
    }
    keydata = dataShot.snapshot.key.toString();
    return keydata;
  }
}
