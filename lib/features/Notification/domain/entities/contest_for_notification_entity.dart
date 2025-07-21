import 'package:equatable/equatable.dart';

class ContestForNotificationEntity extends Equatable {
  final String id;
  final String description;
  final String? departmentId;
  final String title;
  final int virtualRegister;
  final int liveRegister;
  final DateTime startsAt;
  final DateTime endsAt;

  const ContestForNotificationEntity({
    required this.id,
    required this.description,
     this.departmentId,
    required this.title,
    required this.virtualRegister,
    required this.liveRegister,
    required this.startsAt,
    required this.endsAt,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        departmentId,
        title,
        virtualRegister,
        liveRegister,
        startsAt,
        endsAt,
      ];
}
