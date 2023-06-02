import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/teacher_groups/domain/entities/schedule_entity.dart';
import 'package:school_journal/features/teacher_groups/domain/repositories/schedule_repository.dart';
part 'bloc_general_schedule_event.dart';
part 'bloc_general_schedule_state.dart';

class BlocGeneralScheduleBloc
    extends Bloc<BlocGeneralScheduleEvent, BlocGeneralScheduleState> {
  final ScheduleRepository repository;

  BlocGeneralScheduleBloc({required this.repository}) : super(NoGroupsState()) {
    on<AddLessonEvent>((event, emit) async {
      emit(AddedLessonState());
      await repository.addLesson(
        request: ScheduleEntity(
          group: event.groupNameforLesson,
          subject: event.subject,
          lessonRoom: event.lessonRoom,
          lessonTimeStart: event.lessonTimeStart,
          lessonTimeFinish: event.lessonTimeFinish,
          currentDate: event.currentDate,
        ),
      );
    });

    on<DownloadGroupNameEvent>((event, emit) async {
      final resultGroupName = await repository.downloadGroupName();
      if (resultGroupName.isRight()) {
        emit(
          DownloadGroupNameState(
            allNamesGroup: resultGroupName.getOrElse(() => []),
          ),
        );
      }
    });

    on<DownloadSubjectNameEvent>((event, emit) async {
      final resultSubjectGroup = await repository.downloadSubjectName(
          selectedGroup: event.selectedGroup);
      // if (resultSubjectGroup.isRight()) {
      emit(
        DownloadSubjectNameState(
          allSubjectGroup: resultSubjectGroup.getOrElse(() => []),
        ),
      );
      // }
    });

    // Получаем уроки для всех групп
    on<GetAllLessonsEvent>((event, emit) async {
      List dataList = [];
      final resultAllLessons = await repository.getAllLessons(
          selectedDate: event.selectedDate, dataList: dataList);
      // print(dataList);
      // print(event.selectedDate);
      if (resultAllLessons.isRight()) {
        emit(
          GotAllLessonsState(
            allLessons: dataList,
            keyDate: resultAllLessons.getOrElse(() => ''),
          ),
        );
      }
    });

    // Получаем уроки для определенной группы
    on<GetCurrentLessonsEvent>((event, emit) async {
      List dataList = [];
      final resultCurrentLessons = await repository.getCurrentLessons(
          dataList: dataList,
          selectedDate: event.selectedDate,
          groupName: event.groupName);
      if (resultCurrentLessons.isRight()) {
        emit(
          GotCurrentLessonsState(
            lessons: dataList,
            keyDate: resultCurrentLessons.getOrElse(() => ''),
          ),
        );
      }
    });

// Удаляем урок в общем расписании
    on<DeleteLessonsEvent>((event, emit) async {
      final dataBase = FirebaseDatabase.instance.ref();
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final dataShot = dataBase.child(
          'Users/$userId/Schedule/${event.selectedDate}/${event.lessonTimeStart}');

      await dataShot.remove();

      emit(
        UpdateState(
            selectedDate: event.selectedDate,
            lessonTimeStart: event.lessonTimeStart),
      );
    });
  }
}