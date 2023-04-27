class TeacherGroups {
  final String fullName;
  final String email;
  final String confirmPassword;

  TeacherGroups(this.fullName, this.email, this.confirmPassword);
}

class GroupsInformation {
  
  final int studentsAmount;
  final String lessonName;
  final int studentsAtLesson;
  final DateTime nextLesson;
  final bool isHomework;
  final String homework;
  final String lessonRoom;

  GroupsInformation(
      this.studentsAmount,
      this.nextLesson,
      this.lessonName,
      this.studentsAtLesson,
      this.isHomework,
      this.homework,
      this.lessonRoom);
}
