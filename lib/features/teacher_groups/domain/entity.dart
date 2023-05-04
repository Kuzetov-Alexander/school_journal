import 'package:equatable/equatable.dart';

class GroupsInformation extends Equatable {
  final String groupName;
  final int studentsAmount;
  final String lessonName;
  final int studentsAtLesson;
  final String nextLesson;
  final bool isHomework;
  final String homework;
  final String lessonRoom;
  final DateTime currentDay;
  final String subject;
  final DateTime lessonTimeStart;
  final DateTime lessonTimeFinish;
  final bool isMadeWeekly;
  final DateTime dayOfWeek;

  GroupsInformation(
      {required this.groupName,
      this.subject = '',
      DateTime? lessonTimeStart,
      DateTime? lessonTimeFinish,
      this.isMadeWeekly = false,
      DateTime? dayOfWeek,
      DateTime? currentDay,
      this.studentsAmount = 0,
      this.nextLesson = '',
      this.lessonName = '',
      this.studentsAtLesson = 0,
      this.isHomework = false,
      this.homework = '',
      this.lessonRoom = ''})
      : currentDay = currentDay ?? DateTime.now(),
        dayOfWeek = dayOfWeek ?? DateTime.now(),
        lessonTimeStart = lessonTimeStart ?? DateTime.now(),
          lessonTimeFinish = lessonTimeFinish ?? DateTime.now()
        ;

  @override
  List<Object?> get props => [groupName,subject];
}
