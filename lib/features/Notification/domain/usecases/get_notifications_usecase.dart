import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/usecase/usecase.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/notification.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/repositories/notification_repositories.dart';

class GetNotificationsUsecase extends UseCase<List<Notification>, NoParams> {
  final NotificationRepositories repositories;

  GetNotificationsUsecase({required this.repositories});

  @override
  Future<Either<Failure, List<Notification>>> call(NoParams params) async {
    return await repositories.getNotifications();
  }
}
