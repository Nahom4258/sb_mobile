import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/changeVideoStatus/change_video_status_bloc.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../features.dart';

class SubChapterVideoCard extends StatefulWidget {
  const SubChapterVideoCard({
    super.key,
    required this.subchapterVideo,
    required this.courseId,
    required this.selected,
    required this.chapterIndex,
    required this.subChapterIndex,
    required this.chatersVideos,
  });

  final SubchapterVideo subchapterVideo;
  final String courseId;
  final bool selected;
  final int subChapterIndex;
  final int chapterIndex;
  final List<SubchapterVideo> chatersVideos;

  @override
  State<SubChapterVideoCard> createState() => _SubChapterVideoCardState();
}

class _SubChapterVideoCardState extends State<SubChapterVideoCard> {
  late bool isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeVideoStatusBloc, ChangeVideoStatusState>(
      listener: (context, state) {
        //! handle if not successfull. The issue is it is updating all cards if not
      },
      child: InkWell(
        onTap: () {
          VideoPlayerPageRoute(
            courseId: widget.courseId,
            videoLink: widget.subchapterVideo.videoLink,
            $extra: widget.chatersVideos,
          ).go(context);
        },
        child: SizedBox(
          width: 100.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      color: const Color(0xff18786a).withOpacity(.2),
                      width: 80,
                      height: 80,
                      child: Image.network(
                        widget.subchapterVideo.thumbnailUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black38,
                      child: const Icon(
                        size: 30,
                        Icons.play_circle_outlined,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        widget.subchapterVideo.title,
                        // 'Determinants of Matrices of Order 3',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: .5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.subchapterVideo.duration,
                          // '10 mins',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          value: widget.subchapterVideo.isCompleted,
                          onChanged: (value) {
                            // setState(() {
                            //   isSelected = value!;
                            // });
                            context.read<FetchCourseVideosBloc>().add(
                                ChangeVideoStatusLocally(
                                    chapterIndex: widget.chapterIndex,
                                    subchapterindex: widget.subChapterIndex));
                            context
                                .read<ChangeVideoStatusBloc>()
                                .add(ChangeSingleVideoStatusEvent(
                                  videoId: widget.subchapterVideo.id,
                                  isCompleted: value!,
                                ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
