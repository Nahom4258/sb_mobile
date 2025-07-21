import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../repositories/profile_repository.dart.dart';

class ProfileDeleteAccountUsecase extends UseCase<bool, NoParams> {
  final ProfileRepositories profileRepositories;

  ProfileDeleteAccountUsecase({required this.profileRepositories});
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await profileRepositories.deleteAccount();
  }
}
