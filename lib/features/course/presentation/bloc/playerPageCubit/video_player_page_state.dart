part of 'video_player_page_cubit.dart';

class VideoPlayerPageState extends Equatable {
  final String videoTitle;
  final String currentVideoLink;
  final bool isPlaying;
  const VideoPlayerPageState({
    this.videoTitle = '',
    this.currentVideoLink = '',
    this.isPlaying = false,
  });

  factory VideoPlayerPageState.initial() {
    return const VideoPlayerPageState();
  }

  VideoPlayerPageState copyWith({
    String? videoTitle,
    String? currentVideoLink,
    bool? isPlaying,
  }) {
    return VideoPlayerPageState(
      videoTitle: videoTitle ?? this.videoTitle,
      currentVideoLink: currentVideoLink ?? this.currentVideoLink,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [
        videoTitle,
        currentVideoLink,
        isPlaying,
      ];
}
