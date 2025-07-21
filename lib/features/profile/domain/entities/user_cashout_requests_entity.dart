import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_accounts_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/withdraw_requests_entity.dart';

class UserCashoutRequestsEntity extends Equatable {
  final List<WithdrawRequestsEntity> history;
  final List<UserAccountsEntity> accounts;
  final List<WithdrawRequestsEntity> pending;

  const UserCashoutRequestsEntity(
      {required this.history, required this.accounts, required this.pending});
  @override
  List<Object?> get props => [
        history,
        accounts,
        pending,
      ];
}
