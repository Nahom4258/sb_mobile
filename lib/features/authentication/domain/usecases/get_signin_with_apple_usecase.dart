import 'package:dartz/dartz.dart';
import '../../../features.dart';

import '../../../../core/core.dart';

class GetSignInWithAppleUsecase extends UseCase<bool, NoParams> {
  final AuthenticationRepository repository;

  GetSignInWithAppleUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isAuthenticatedWithApple();
  }
}
