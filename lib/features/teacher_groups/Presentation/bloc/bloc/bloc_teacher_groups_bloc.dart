import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_teacher_groups_event.dart';
part 'bloc_teacher_groups_state.dart';

class BlocTeacherGroupsBloc extends Bloc<BlocTeacherGroupsEvent, BlocTeacherGroupsState> {
  BlocTeacherGroupsBloc() : super(BlocTeacherGroupsInitial()) {
    on<BlocTeacherGroupsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}