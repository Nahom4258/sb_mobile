import 'package:skill_bridge_mobile/core/utils/date_time_convert.dart';

import '../../../features.dart';

class CustomContestModel extends CustomContest {
  const CustomContestModel({required super.id, required super.title, required super.isLive, required super.startsAt, required super.endsAt, required super.userScore});
  
  factory CustomContestModel.fromJson(Map<String, dynamic> json) {
    return CustomContestModel(
        id: json['_id'] ?? '',
        title: json['title'] ?? '',
        isLive: json['isLive'] ?? false,
        startsAt: json['startsAt'] == null ? DateTime.now() : convertToLocal(DateTime.parse(json['startsAt'])),
        endsAt: json['endsAt']  == null ? DateTime.now() : convertToLocal(DateTime.parse(json['endsAt'])),
        userScore: json['userScore'] ?? 0,
    );
  }
}