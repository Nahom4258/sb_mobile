import 'package:equatable/equatable.dart';

class LiveContest extends Equatable {
  const LiveContest({required this.id, required this.description, required this.departmentId, required this.title, required this.liveRegister, required this.virtualRegister, required this.startsAt, required this.endsAt, required this.createdAt, required this.updatedAt, required this.isLive,});

  final String id;
  final String description;
  final String departmentId;
  final String title;
  final int liveRegister;
  final int virtualRegister;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isLive;

  @override
  List<Object?> get props => [id, description, departmentId, title, liveRegister, virtualRegister, startsAt, endsAt, createdAt, updatedAt, isLive,];

}