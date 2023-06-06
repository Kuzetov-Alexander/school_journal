part of 'weekly_schedule_bloc.dart';

abstract class WeeklyScheduleState extends Equatable {
  const WeeklyScheduleState();
  
  @override
  List<Object> get props => [];
}

class WeeklyScheduleInitial extends WeeklyScheduleState {}
