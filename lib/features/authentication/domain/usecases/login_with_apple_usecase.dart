import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class SignInWithAppleUsecase extends UseCase<UserCredential, NoParams> {
  final AuthenticationRepository repository;

  SignInWithAppleUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserCredential>> call(params) async {
    return await repository.signInWithApple();
  }
}
