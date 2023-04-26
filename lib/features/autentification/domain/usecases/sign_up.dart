// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:school_journal/core/error/failure.dart';
// import 'package:school_journal/core/usecases/usecase.dart';
// import 'package:school_journal/features/autentification/domain/repositories/user_repository.dart';

// class SignUp extends UseCase<void, DataForAuth> {
//   final UserRepository userRepository;

//   SignUp({required this.userRepository});

//   @override
//   Future<Either<Failure, void>> call(DataForAuth params) {
//     return userRepository.signUp(
//         email: params.email, password: params.password);
//   }
// }

// class SignIn extends UseCase<void, DataForAuth> {
//   final UserRepository userRepository;

//   SignIn({required this.userRepository});

//   @override
//   Future<Either<Failure, void>> call(DataForAuth params) {
//     return userRepository.signIn(
//         email: params.email, password: params.password);
//   }
// }

// class SendVerificationEmail extends UseCase<void, DataForAuth> {
//   final UserRepository userRepository;

//   SendVerificationEmail({required this.userRepository});

//   @override
//   Future<Either<Failure, void>> call(DataForAuth params) {
//     return userRepository.sendEmailVerification();
//   }
// }

// class SignOut extends UseCaseEmpty<void> {
//   final UserRepository userRepository;

//   SignOut({required this.userRepository});

//   @override
//   Future<Either<Failure, void>> call() {
//     return userRepository.signOut();
//   }
// }

// class DataForAuth extends Equatable {
//   final String email;
//   final String password;

//   const DataForAuth({
//     required this.email,
//     required this.password,
//   });

//   @override
//   List<Object?> get props => [email, password];
// }
