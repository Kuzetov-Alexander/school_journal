// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CreateGroupEntity extends Equatable {
  final String groupName;
  final String nextLesson;
  final int studentsAmount;
  const CreateGroupEntity({
    required this.groupName,
    this.nextLesson = '',
    this.studentsAmount = 0,
  });

  @override
  List<Object?> get props => [groupName, nextLesson, studentsAmount];
}
