part of 'fetch_course_videos_bloc.dart';

class FetchCourseVideosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSingleCourseVideosEvent extends FetchCourseVideosEvent {
  FetchSingleCourseVideosEvent({
    required this.courseId,
    required this.channelId,
  });

  final String courseId;
  final String channelId;

  @override
  List<Object> get props => [courseId, channelId];
}

class ChangeVideoStatusLocally extends FetchCourseVideosEvent {
  final int chapterIndex;
  final int subchapterindex;

  ChangeVideoStatusLocally(
      {required this.chapterIndex, required this.subchapterindex});
}
