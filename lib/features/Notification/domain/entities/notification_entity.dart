import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String notificationId;
  final String title;
  final String content;
  final DateTime date;
  final bool isPersonal;

  const NotificationEntity(
      {required this.notificationId,
      required this.title,
      required this.content,
      required this.date,
      required this.isPersonal});

  @override
  List<Object?> get props => [notificationId, title, content, date, isPersonal];
}
