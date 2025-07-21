import '../../../features.dart';

class LiveContestModel extends LiveContest {
  const LiveContestModel({
    required super.id,
    required super.description,
    required super.departmentId,
    required super.title,
    required super.liveRegister,
    required super.virtualRegister,
    required super.startsAt,
    required super.endsAt,
    required super.createdAt,
    required super.updatedAt,
    required super.isLive,
  });

  factory LiveContestModel.fromJson(Map<String, dynamic> json) {
    return LiveContestModel(
      id: json['_id'] ?? '',
      description: json['description'] ?? '',
      departmentId: json['departmentId'] ?? '',
      title: json['title'] ?? '',
      liveRegister: json['liveRegister'] ?? 0,
      virtualRegister: json['virtualRegister'] ?? 0,
      startsAt: json['startsAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['startsAt']),
      endsAt: json['endsAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['endsAt']),
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['updatedAt']),
      isLive: json['isLive'] ?? false,
    );
  }
}
