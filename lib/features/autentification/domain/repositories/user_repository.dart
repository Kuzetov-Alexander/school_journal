import 'package:dartz/dartz.dart';
import 'package:school_journal/core/error/failure.dart';

/// Уровень хранилища представляет собой оболочку вокруг одного или
/// нескольких поставщиков данных, с которыми связывается уровень Bloc.
/// 
/// Контракт Domain repository
/// 
/// Dartz установлен для представления 2-х любых типов Either<Left, Right>,
/// L - ошибки, R - выполнение кода.
/// 
/// То есть, мы будем прописывать два исхода событий,
/// в одном из которых будут ошибки, а в другом выполнение кода метода.
/// 
/// Для вызова в репозитории
abstract class UserRepository {

  Future<Either<Failure, Future<void>>> signUp(
      {required String email, required String password});

  Future<Either<Failure, Future<void>>> signIn(
      {required String email, required String password});

  Future<Either<Failure, Future<void>>> signOut();
}