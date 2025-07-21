import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/sender_or_reciever_entity.dart';

class SenderOrRecieverModel extends SenderOrRecieverEntity {
  const SenderOrRecieverModel({
    required super.id,
    required super.name,
    required super.lastName,
    super.avatar,
  });
  factory SenderOrRecieverModel.fromJson(Map<String, dynamic> json) {
    return SenderOrRecieverModel(
      id: json['_id'],
      name: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      avatar: json['avatar'] ?? defaultProfileAvatar,
    );
  }
}
