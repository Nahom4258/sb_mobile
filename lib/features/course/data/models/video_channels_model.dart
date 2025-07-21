import 'package:skill_bridge_mobile/features/course/domain/entities/course_video_channels_entity.dart';

class VideoChannelsModel extends CourseVideoChannelEntity {
  const VideoChannelsModel({
    required super.channelId,
    required super.channelName,
    required super.channelUrl,
    required super.channelType,
    required super.channelTumbnail,
    required super.totalVideoCount,
    required super.channelDescritption,
    required super.channelSubscribersCount,
    required super.userAnalysisCount,
  });
  factory VideoChannelsModel.fromJson(Map<String, dynamic> json) {
    return VideoChannelsModel(
      channelId: json['channel']['_id'] ?? '',
      channelName: json['channel']['channelName'] ?? '',
      channelUrl: json['channel']['channelUrl'] ?? '',
      channelType: json['channel']['channelType'] ?? '',
      channelTumbnail: json['channel']['thumbnail'] ??
          'https://img.freepik.com/premium-psd/school-education-admission-youtube-thumbnail-web-banner-template_475351-441.jpg',
      totalVideoCount: json['totalVideoCount'] ?? 0,
      channelDescritption:json['channel']['channelDescritption'] ?? 0,
      channelSubscribersCount: json['channel']['channelSubscribersCount'] ?? 0,
      userAnalysisCount: json['userAnalysisCount'] ?? 0,
    );
  }
}
