

// class SignUp extends UseCase<Future<void>, DataForAuth> {
//   final UserRepository userRepository;

//   SignUp({required this.userRepository});

//   @override
//   Future<Either<Failure, Future<void>>> call(
//       {required DataForAuth params}) async {
//     return await userRepository.signUp(
//         email: params.email, password: params.password);
//   }
// }

// class SignIn extends UseCase<Future<void>, DataForAuth> {
//   final UserRepository userRepository;

//   SignIn({required this.userRepository});

//   @override
//   Future<Either<Failure, Future<void>>> call(
//       {required DataForAuth params}) async {
//     return await userRepository.signIn(
//         email: params.email, password: params.password);
//   }
// }

// class SignOut extends UseCase<Future<void>, DataForAuth> {
//   final UserRepository userRepository;

//   SignOut({required this.userRepository});

//   @override
//   Future<Either<Failure, Future<void>>> call() async {
//     return await userRepository.signOut();
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
