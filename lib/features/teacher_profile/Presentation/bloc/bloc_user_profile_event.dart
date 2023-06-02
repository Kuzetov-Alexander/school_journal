part of 'bloc_user_profile_bloc.dart';

abstract class BlocUserProfileEvent extends Equatable {
  const BlocUserProfileEvent();

  @override
  List<Object> get props => [];
}
 class DeleteUserProfileEvent extends BlocUserProfileEvent {}