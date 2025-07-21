import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_refferal_info_entity.dart';

class GetUserRefferalInfoUsecase
    extends UseCase<UserRefferalInfoEntity, NoParams> {
  final ProfileRepositories profileRepositories;

  GetUserRefferalInfoUsecase({required this.profileRepositories});
  @override
  Future<Either<Failure, UserRefferalInfoEntity>> call(NoParams params) async {
    return await profileRepositories.getUserRefferalInfo();
  }
}
