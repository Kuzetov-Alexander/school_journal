// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// Класс с типом точно соответсвуещим типу Exception
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

/// Дополнительная обработка ошибок
class DataBaseFailure extends Failure {
  final String? message;
  DataBaseFailure([this.message]);
}
