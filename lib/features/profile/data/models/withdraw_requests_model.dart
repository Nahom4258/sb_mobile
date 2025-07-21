import 'package:skill_bridge_mobile/features/profile/domain/entities/withdraw_requests_entity.dart';

class WithdrawRequestsModel extends WithdrawRequestsEntity {
  const WithdrawRequestsModel({
    required super.id,
    required super.userId,
    required super.ammountInCash,
    required super.accountInCoin,
    required super.status,
    required super.date,
    required super.accountId,
  });
  factory WithdrawRequestsModel.fromJson(Map<String, dynamic> json) {
    return WithdrawRequestsModel(
      id: json['_id'],
      userId: json['userId'],
      ammountInCash: json['ammountInCash'] ?? 0,
      accountInCoin: json['accountInCoin'] ?? 0,
      status: json['status'],
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      accountId: json['accountId'],
    );
  }
}
