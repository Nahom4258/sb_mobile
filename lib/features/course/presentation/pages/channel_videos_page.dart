import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/core.dart';

import '../../../../core/utils/snack_bar.dart';
import '../../../features.dart';

class CourseChannelVideosPage extends StatefulWidget {
  const CourseChannelVideosPage({
    super.key,
    required this.courseId,
    required this.channelId,
    required this.channelName,
    required this.channelUrl,
    required this.channelDescritption,
    required this.channelSubscribersCount
  });

  final String courseId;
  final String channelId;
  final String channelName;
  final String channelUrl;
  final String channelDescritption;
  final int channelSubscribersCount;
  @override
  State<CourseChannelVideosPage> createState() =>
      _CourseChannelVideosPageState();
}

class _CourseChannelVideosPageState extends State<CourseChannelVideosPage> {
  @override
  void initState() {
    super.initState();
    context.read<FetchCourseVideosBloc>().add(
          FetchSingleCourseVideosEvent(
            courseId: widget.courseId,
            channelId: widget.channelId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: BlocBuilder<CourseWithUserAnalysisBloc,
            CourseWithUserAnalysisState>(
          builder: (context, state) {
            String courseName = 'Videos';
            if (state is CourseLoadedState) {
              courseName =
                  '${state.userCourseAnalysis.course.name} Grade ${state.userCourseAnalysis.course.grade}';
            }
            return Text(
              courseName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Text(
              maxLines: 2,
              textAlign: TextAlign.center,
              '${widget.channelName} Channel Videos',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, right: 3.w, top: 2.w),
                child:
                    BlocListener<FetchCourseVideosBloc, FetchCourseVideosState>(
                  listener: (context, state) {
                    if (state is FetchCourseVideosFailed &&
                        state.failure is RequestOverloadFailure) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar(state.failure.errorMessage));
                    }
                  },
                  child: BlocBuilder<FetchCourseVideosBloc,
                      FetchCourseVideosState>(
                    builder: (context, state) {
                      if (state is FetchCourseVideosLoading) {
                        return _courseVideoTabShimmer();
                      } else if (state is FetchCourseVideosLoaded) {
                        state.chapterVideos.sort(
                          (a, b) => a.order.compareTo(b.order),
                        );

                        return Column(
                          children: List.generate(
                            state.chapterVideos.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: ChapterVideoWidget(
                                chapterVideo: state.chapterVideos[index],
                                courseId: widget.courseId,
                                chapterIndex: index,
                              ),
                            ),
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Shimmer _courseVideoTabShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Column(
              children: List.generate(
                4,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20.w,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 45.w,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 24.w,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 3.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    width: 45.w,
                                    height: 2.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 16.w,
                                    height: 1.5.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
