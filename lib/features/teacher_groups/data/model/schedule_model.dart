// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';

class ScheduleEntityModel extends ScheduleEntity {
  const ScheduleEntityModel(
      {super.changedtimeFinish = '',
      super.changedtimeStart = '',
      required super.group,
      required super.subject,
      required super.lessonRoom,
       super.lessonTimeStart ='',
       super.lessonTimeFinish ='',
      required super.selectedDate});

  Map<String, Map<Object?, Object?>> addLessontoMap() {
    return {
      lessonTimeStart: {
        'Subject': subject,
        'LessonRoom': lessonRoom,
        'LessonTimeStart': lessonTimeStart,
        'LessonTimeFinish': lessonTimeFinish,
        'Group': group,
        'Homework': 'не задано',
        'StudentAmountatLesson': '0'
      }
    };
  }

  Map<String, Map<Object?, Object?>> changeLessontoMap() {
    return {
      changedtimeStart: {
        'Subject': subject,
        'LessonRoom': lessonRoom,
        'LessonTimeStart': changedtimeStart,
        'LessonTimeFinish': changedtimeFinish,
        'Group': group,
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