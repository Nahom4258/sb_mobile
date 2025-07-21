import 'package:skill_bridge_mobile/features/profile/domain/entities/user_refferal_info_entity.dart';

class UserRefferalInfoModel extends UserRefferalInfoEntity {
  const UserRefferalInfoModel({
    required super.refferalCount,
    required super.totalCoin,
  });

  factory UserRefferalInfoModel.fromJson(Map<String, dynamic> json) {
    return UserRefferalInfoModel(
      totalCoin: json['coin'] ?? 0,
      refferalCount: json['refferal'] ?? 0,
    );
  }
}
