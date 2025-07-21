import 'package:skill_bridge_mobile/features/profile/data/models/user_accounts_model.dart';
import 'package:skill_bridge_mobile/features/profile/data/models/withdraw_requests_model.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_cashout_requests_entity.dart';

class UserCashoutRequestsModel extends UserCashoutRequestsEntity {
  const UserCashoutRequestsModel({
    required super.history,
    required super.accounts,
    required super.pending,
  });
  factory UserCashoutRequestsModel.fromJson(Map<String, dynamic> json) {
    List<WithdrawRequestsModel> history = (json['history'] ?? [])
        .map<WithdrawRequestsModel>((n) => WithdrawRequestsModel.fromJson(n))
        .toList();
    List<WithdrawRequestsModel> pending = (json['pending'] ?? [])
        .map<WithdrawRequestsModel>((n) => WithdrawRequestsModel.fromJson(n))
        .toList();
    List<UserAccountsModel> userAccounts = (json['userAccounts'] ?? [])
        .map<UserAccountsModel>((n) => UserAccountsModel.fromJson(n))
        .toList();
    return UserCashoutRequestsModel(
      history: history,
      accounts: userAccounts,
      pending: pending,
    );
  }
}
