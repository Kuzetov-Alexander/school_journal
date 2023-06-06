
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weekly_schedule_event.dart';
part 'weekly_schedule_state.dart';

class WeeklyScheduleBloc extends Bloc<WeeklyScheduleEvent, WeeklyScheduleState> {
  WeeklyScheduleBloc() : super(WeeklyScheduleInitial()) {
    on<WeeklyScheduleEvent>((event, emit) {
      
    });
  }
}
