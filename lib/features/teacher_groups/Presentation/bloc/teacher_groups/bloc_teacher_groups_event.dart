

import 'package:equatable/equatable.dart';

abstract class BlocTeacherGroupsEvent extends Equatable {
  const BlocTeacherGroupsEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupEvent extends BlocTeacherGroupsEvent {
  final String groupName;
  const CreateGroupEvent({required this.groupName});
}

class DeleteGroupEvent extends BlocTeacherGroupsEvent {
  final String key;
  const DeleteGroupEvent({required this.key});
}


