import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String fullName;
  StudentEntity({required this.fullName});

  final allUsers = <StudentEntity>[
    StudentEntity(fullName: 'Kuzetov Alexander Olegovich'),
    StudentEntity(fullName: 'Frolov Alexander Vladimirovich'),
    StudentEntity(fullName: 'Efanov Alexander Olegovich'),
    StudentEntity(fullName: 'Kotegov Alexander Olegovich'),
    StudentEntity(fullName: 'Miler Alexander Olegovich'),
    StudentEntity(fullName: 'Tropin Alexander Olegovich'),
    StudentEntity(fullName: 'Kozlov Alexander Olegovich'),
    StudentEntity(fullName: 'Okhmak Alexander Olegovich'),
    StudentEntity(fullName: 'Chimrov Alexander Olegovich'),
    StudentEntity(fullName: 'Prosvirov Alexander Olegovich'),
    StudentEntity(fullName: 'Oreckhov Alexander Olegovich'),
    StudentEntity(fullName: 'Chuprov Alexander Olegovich'),
    StudentEntity(fullName: 'Putin Alexander Olegovich'),
  ];

  @override
  List<Object?> get props => [fullName];
}
