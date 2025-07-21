import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_player_page_state.dart';

class VideoPlayerPageCubit extends Cubit<VideoPlayerPageState> {
  VideoPlayerPageCubit() : super(const VideoPlayerPageState());

  void setVideoTitle({required String videoTitle}) {
    emit(state.copyWith(videoTitle: videoTitle));
  }

  void setCurrentVideo({required String videoLink}) {
    emit(state.copyWith(currentVideoLink: videoLink));
  }

  void setVideoState({required int st}) {
    if (st == 2) {
      emit(state.copyWith(isPlaying: true));
    } else {
      emit(state.copyWith(isPlaying: false));
    }
  }
}
