import 'package:equatable/equatable.dart';

class TeacherGroups {
  final String fullName;
  final String email;
  final String confirmPassword;

  TeacherGroups(this.fullName, this.email, this.confirmPassword);
}

class GroupsInformation extends Equatable {
  final int studentsAmount;
  final String lessonName;
  final int studentsAtLesson;
  final DateTime nextLesson;
  final bool isHomework;
  final String homework;
  final String lessonRoom;

  const GroupsInformation(this.studentsAmount, this.nextLesson, this.lessonName,
      this.studentsAtLesson, this.isHomework, this.homework, this.lessonRoom);
      
        @override
        
        List<Object?> get props => [studentsAmount];
}

class AddNewGroupEntity {
  final int studentsAmount;
  final String groupName;
  final String nextLesson;

  AddNewGroupEntity({required this.studentsAmount,required this.groupName,required this.nextLesson});
}
