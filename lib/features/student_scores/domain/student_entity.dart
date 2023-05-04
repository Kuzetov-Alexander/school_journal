import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String fullName;
  final int score;
  final double averageScore;
  final double attestationScore;
  final String email;
  final String studentLink;
  final bool isDeleted;
  final bool visitedLesson;
  final String subject;
  final DateTime currentDay;

  const StudentEntity(
      this.fullName,
      this.score,
      this.averageScore,
      this.attestationScore,
      this.email,
      this.studentLink,
      this.isDeleted,
      this.visitedLesson,
      this.subject, this.currentDay);

  @override
  List<Object?> get props => [
        fullName,
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
