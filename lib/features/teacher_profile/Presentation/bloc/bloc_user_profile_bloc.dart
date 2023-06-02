import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/teacher_profile/domain/repositories/user_profile_repository.dart';

part 'bloc_user_profile_event.dart';
part 'bloc_user_profile_state.dart';

class BlocUserProfileBloc
    extends Bloc<BlocUserProfileEvent, BlocUserProfileState> {
  final UserProfileRepository repository;
  BlocUserProfileBloc({required this.repository})
      : super(BlocUserProfileInitial()) {
    on<DeleteUserProfileEvent>((event, emit) async {
      await repository.downloadGroupName();
      emit(DeleteUserProfileState());
    });
  }
}
