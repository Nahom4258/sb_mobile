import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/usecase/usecase.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/notification.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/usecases/get_notifications_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUsecase getNotificationsUsecase;

  NotificationBloc({required this.getNotificationsUsecase})
      : super(NotificationInitial()) {
    on<GetNotificationsEvent>((event, emit) async {
      emit(NotificationsLoadingState());
      final notifications = await getNotificationsUsecase(NoParams());
      notifications.fold((failure) {
        emit(NotificationsFailedtate(failure: failure));
      }, (notifications) {
        emit(NotificationsLoadedState(notifications: notifications));
      });
    });
  }
}
