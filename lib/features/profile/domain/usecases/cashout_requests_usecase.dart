import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_cashout_requests_entity.dart';

class CashoutRequestsUsecase
    extends UseCase<UserCashoutRequestsEntity, NoParams> {
  final ProfileRepositories profileRepositories;

  CashoutRequestsUsecase({required this.profileRepositories});

  @override
  Future<Either<Failure, UserCashoutRequestsEntity>> call(
      NoParams params) async {
    return await profileRepositories.getUserCashoutRequests();
  }
}
