// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final String group;
  final String subject;
  final String lessonRoom;
  final String lessonTimeStart;
  final String lessonTimeFinish;
   final String changedtimeStart;
   final String changedtimeFinish;
  final String selectedDate;

  const ScheduleEntity({this.changedtimeFinish='',this.changedtimeStart='',
    required this.group,
    required this.subject,
    required this.lessonRoom,
     this.lessonTimeStart ='',
     this.lessonTimeFinish ='',
    required this.selectedDate,
  });
  @override
  List<Object?> get props => [
        group,
        subject,
        lessonRoom,
        lessonTimeStart,
        lessonTimeFinish,
        selectedDate,
        changedtimeStart,
        changedtimeFinish
      ];
}


// class GroupsInformation extends Equatable {
//   final String groupName;
//   final int studentsAmount;
//   final String lessonName;
//   final int studentsAtLesson;
//   final String nextLesson;
//   final bool isHomework;
//   final String homework;
//   final String lessonRoom;
//   final DateTime currentDay;
//   final String subject;
//   final DateTime lessonTimeStart;
//   final DateTime lessonTimeFinish;
//   final bool isMadeWeekly;
//   final DateTime dayOfWeek;

//   GroupsInformation(
//       {required this.groupName,
//       this.subject = '',
//       DateTime? lessonTimeStart,
//       DateTime? lessonTimeFinish,
//       this.isMadeWeekly = false,
//       DateTime? dayOfWeek,
//       DateTime? currentDay,
//       this.studentsAmount = 0,
//       this.nextLesson = '',
//       this.lessonName = '',
//       this.studentsAtLesson = 0,
//       this.isHomework = false,
//       this.homework = '',
//       this.lessonRoom = ''})
//       : currentDay = currentDay ?? DateTime.now(),
//         dayOfWeek = dayOfWeek ?? DateTime.now(),
//         lessonTimeStart = lessonTimeStart ?? DateTime.now(),
//         lessonTimeFinish = lessonTimeFinish ?? DateTime.now();

//   @override
//   List<Object?> get props => [groupName, subject];
// }
