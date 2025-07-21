part of 'get_video_channels_cubit.dart';

class GetVideoChannelsState extends Equatable {
  const GetVideoChannelsState();

  @override
  List<Object> get props => [];
}

class GetVideoChannelsInitial extends GetVideoChannelsState {}

class GetVideoChannelsLoadingState extends GetVideoChannelsState {}

class GetVideoChannelsLoadedState extends GetVideoChannelsState {
  final List<CourseVideoChannelEntity> videoChannels;

  const GetVideoChannelsLoadedState({required this.videoChannels});
  @override
  List<Object> get props => [videoChannels];
}

class GetVideoChannelsFailedState extends GetVideoChannelsState {
  final Failure failure;

  const GetVideoChannelsFailedState({required this.failure});
}
