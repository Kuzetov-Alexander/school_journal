import 'package:equatable/equatable.dart';

class EntityStudentScores extends Equatable {
  final String? fullName;
  final String? groupName;
  final int? score;
  final double? averageScore;
  final double? attestationScore;
  final String? email;
  final String? studentLink;
  final bool? isDeleted;
  final bool? visitedLesson;
  final String? subject;
  final String? currentDay;

  const EntityStudentScores({
    this.fullName,
    this.groupName,
    this.score,
    this.averageScore,
    this.attestationScore,
    this.email,
    this.studentLink,
    this.isDeleted,
    this.visitedLesson,
    this.subject,
    this.currentDay,
  });

  @override
  List<Object?> get props => [
        fullName,
        groupName,
        score,
        averageScore,
        attestationScore,
        email,
        studentLink,
        isDeleted,
        visitedLesson,
        subject
      ];
}
