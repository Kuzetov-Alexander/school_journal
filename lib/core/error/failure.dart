import 'package:equatable/equatable.dart';

/// Класс с типом точно соответсвуещим типу Exception
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

/// Дополнительная обработка ошибок
class ServerFailure extends Failure {}

/// Дополнительная обработка ошибок
class CacheFailure extends Failure {}
