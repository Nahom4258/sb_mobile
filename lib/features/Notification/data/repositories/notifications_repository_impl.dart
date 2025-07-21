import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/exeption_to_failure_map.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/network/network.dart';
import 'package:skill_bridge_mobile/features/Notification/data/datasources/notifications_remotedatasource.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/notification.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/repositories/notification_repositories.dart';

class NotificationsRepositoryImpl implements NotificationRepositories {
  final NotificationsRemotedatasource remoteDataSource;
  final NetworkInfo networkInfo;

  NotificationsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Notification>>> getNotifications() async {
    if (await networkInfo.isConnected) {
      try {
        final notifications = await remoteDataSource.getNotifications();
        return Right(notifications);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
