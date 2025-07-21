import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/course/domain/entities/course_video_channels_entity.dart';

import '../../../features.dart';

class GetVideoChannelsUsecase
    extends UseCase<List<CourseVideoChannelEntity>, GetVideoChannelParams> {
  final CourseRepositories courseRepositories;

  GetVideoChannelsUsecase({
    required this.courseRepositories,
  });

  @override
  Future<Either<Failure, List<CourseVideoChannelEntity>>> call(
      GetVideoChannelParams params) async {
    return await courseRepositories.getVideoChannels(courseId: params.courseId);
  }
}

class GetVideoChannelParams extends Equatable {
  final String courseId;

  const GetVideoChannelParams({
    required this.courseId,
  });

  @override
  List<Object?> get props => [courseId];
}
