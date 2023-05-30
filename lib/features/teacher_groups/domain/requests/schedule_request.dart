import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';

class ScheduleRequest extends ScheduleEntity {
  const ScheduleRequest({
    required super.groupNameforLesson,
    required super.subject,
    required super.lessonRoom,
    required super.lessonTimeStart,
    required super.lessonTimeFinish,
    required super.currentDate,
  });
}
