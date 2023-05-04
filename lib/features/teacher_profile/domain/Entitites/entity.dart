import 'package:equatable/equatable.dart';

class UserProfileInformationTeacher extends Equatable {
  final String fullName;
  final String email;

  const UserProfileInformationTeacher({
   required this.fullName ,
  required  this.email ,
  });

  @override
  
  List<Object?> get props => [fullName,email];
}

class Attestation extends Equatable {
  final double gradeForVisit;
  final double gradeForFive;
  final double gradeForFour;
  final double gradeForThree;
  final double gradeForTwo;

  const Attestation(
      {this.gradeForVisit = 0.25,
      this.gradeForFive = 1,
      this.gradeForFour = 0.5,
      this.gradeForThree = 0.25,
      this.gradeForTwo = 0});

  @override
 
  List<Object?> get props => [];
}
