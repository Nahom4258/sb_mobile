import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/notification.dart';

abstract class NotificationRepositories {
  Future<Either<Failure, List<Notification>>> getNotifications();
}
