import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/course/domain/entities/course_video_channels_entity.dart';
import 'package:skill_bridge_mobile/features/course/domain/usecases/get_video_channels.dart';

part 'get_video_channels_state.dart';

class GetVideoChannelsCubit extends Cubit<GetVideoChannelsState> {
  final GetVideoChannelsUsecase getVideoChannelsUsecase;
  GetVideoChannelsCubit({required this.getVideoChannelsUsecase})
      : super(GetVideoChannelsInitial());

  void getVideoChannels({required String courseId}) async {
    emit(GetVideoChannelsLoadingState());
    final channels = await getVideoChannelsUsecase(
        GetVideoChannelParams(courseId: courseId));
    final state = channels.fold(
      (failure) => GetVideoChannelsFailedState(failure: failure),
      (data) => GetVideoChannelsLoadedState(videoChannels: data),
    );
    emit(state);
  }
}
