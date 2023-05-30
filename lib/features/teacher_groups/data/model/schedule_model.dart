// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';

class ScheduleEntityModel extends ScheduleEntity {
  const ScheduleEntityModel(
      {required super.groupNameforLesson,
      required super.subject,
      required super.lessonRoom,
      required super.lessonTimeStart,
      required super.lessonTimeFinish,
      required super.currentDate});

  Map<String, Map> toMap() {
    return {
      lessonTimeStart: {
        'Subject': subject,
        'LessonRoom': lessonRoom,
        'lessonTimeStart': lessonTimeStart,
        'lessonTimeFinish': lessonTimeFinish,
        'groupNameforLesson': groupNameforLesson,
        'Homework': 'не задано',
        'StudentAmountatLesson': '0'
      }
    };
  }

  // final lessonData = {
  //   model.lessonTimeStart: {
  //     'Subject': subject,
  //     'LessonRoom': lessonRoom,
  //     'lessonTimeStart': model.lessonTimeStart,
  //     'lessonTimeFinish': model.lessonTimeFinish,
  //     'Group': model.groupNameforLesson,
  //     'Homework': 'не задано',
  //     'StudentAmountatLesson': '0'
  //   }
  // };
}

// class Params {
//   static Map<String, dynamic> toMap(ScheduleEntityModel model);
// }