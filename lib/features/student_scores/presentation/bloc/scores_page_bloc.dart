import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scores_page_event.dart';
part 'scores_page_state.dart';

class ScoresPageBloc extends Bloc<ScoresPageEvent, ScoresPageState> {
  final dataBase = FirebaseDatabase.instance.ref();
  final userId = FirebaseAuth.instance.currentUser?.uid;

  ScoresPageBloc() : super(ScoresPageInitial()) {
    on<AddNewStudentEvent>((event, emit) async {
      final dataBase = FirebaseDatabase.instance
          .ref()
          .child('Users/$userId/Groups/${event.groupName}');

      final allSubjects = await dataBase.child('allSubject').once();
      late dynamic data;
      if (allSubjects.snapshot.value is String) {
        data = allSubjects.snapshot.value as String;
      } else {
        data = allSubjects.snapshot.value as Map<Object?, Object?>;
      }

      final List<String> subjects =
          []; // Здесь будут храниться все значения ключа "GroupName"

      final List<dynamic> dataList = data.keys.toList();

      Map<String?, Object?> mapSubjects = {};
      Map generalMap = {
        'data': {'grade': '', 'visit': ''}
      };

      for (var item in dataList) {
        mapSubjects[item] = generalMap;
      }

      final studentData = {
        event.studentName: {
          'Email': event.email,
          'Subjects': mapSubjects,
        }
      };

      dataBase.child('allStudents').update(studentData);
      emit(AddedNewStudent());
    });
  }
}
