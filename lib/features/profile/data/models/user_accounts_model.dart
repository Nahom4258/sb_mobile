import 'package:skill_bridge_mobile/features/profile/domain/entities/user_accounts_entity.dart';

class UserAccountsModel extends UserAccountsEntity {
  const UserAccountsModel({
    required super.id,
    required super.userId,
    required super.accountNumber,
    required super.accountNumberHolder,
    required super.bankName,
  });
  factory UserAccountsModel.fromJson(Map<String, dynamic> json) {
    return UserAccountsModel(
      id: json['_id'],
      userId: json['userId'],
      accountNumber: json['accountNumber'],
      accountNumberHolder: json['accountHolderName'],
      bankName: json['bankName'],
    );
  }
}
