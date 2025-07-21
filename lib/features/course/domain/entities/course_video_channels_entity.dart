import 'package:equatable/equatable.dart';

class CourseVideoChannelEntity extends Equatable {
  final String channelId;
  final String channelName;
  final String channelUrl;
  final String channelType;
  final String channelTumbnail;
  final int totalVideoCount;
  final int userAnalysisCount;
  final String channelDescritption;
  final int channelSubscribersCount;

  const CourseVideoChannelEntity({
    required this.channelId,
    required this.channelName,
    required this.channelUrl,
    required this.channelType,
    required this.channelTumbnail,
    required this.totalVideoCount,
    required this.userAnalysisCount,
    required this.channelSubscribersCount,
    required this.channelDescritption
  });

  @override
  List<Object?> get props => [
        channelId,
        channelName,
        channelUrl,
        channelType,
        channelTumbnail,
        channelDescritption,
        channelSubscribersCount
      ];
}
