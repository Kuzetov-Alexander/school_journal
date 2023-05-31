import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:school_journal/features/teacher_groups/data/model/schedule_model.dart';
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';

abstract class RemoteDataFirebase {
  Future<void> createGroup({required String groupName});
  Future<void> removeGroup({required String keyGroup});
  Future<void> addLesson({required ScheduleEntity request});
  Future<void> downloadGroupName({required List<String> request});
  Future<void> downloadSubjectName(
      {required List<dynamic> dataRequest, required String selectedGroup});
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
  Future<void> downloadGroupName({required List<String> request}) async {
    final dataBase = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final dataSnapshot = await dataBase.child('Users/$userId/Groups').get();

    if (dataSnapshot.exists) {
      final Map<Object?, Object?> data =
          dataSnapshot.value as Map<Object?, Object?>;

      final List<dynamic> dataList = data.values.toList();
      for (final dynamic element in dataList) {
        if (element is Map<dynamic, dynamic>) {
          final String? groupName = element['GroupName'] as String?;
          if (groupName != null) {
            request.add(groupName);
          }
        }
      }
    }
  }

  @override
  Future<void> downloadSubjectName(
      {required List<dynamic> dataRequest,
      required String selectedGroup}) async {
    final dataBase = FirebaseDatabase.instance.ref();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final dataShot = await dataBase
        .child('Users/$userId/Groups/$selectedGroup/allSubject')
        .once();

    final dataSubject = dataShot.snapshot.value;

    if (dataSubject is Map) {
      dataRequest.addAll(dataSubject.keys.toList());
      // dataRequest = dataSubject.keys.toList();
      print(dataRequest);
    }
  }
}















 // dataList
      //     .where((element) =>
      //         element is Map<dynamic, dynamic> &&
      //         (element['GroupName'] as String?) != null)
      //     .map((e) => e['GroupName'] as String).toList();

// return [...dataRequest, ...dataSubject.keys.toList()];