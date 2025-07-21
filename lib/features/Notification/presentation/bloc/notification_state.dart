part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationsLoadedState extends NotificationState {
  final List<Notification> notifications;
  const NotificationsLoadedState({required this.notifications});
}

class NotificationsLoadingState extends NotificationState {}

class NotificationsFailedtate extends NotificationState {
  final Failure failure;
  const NotificationsFailedtate({required this.failure});
}
