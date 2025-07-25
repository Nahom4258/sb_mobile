// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_bridge_mobile/core/widgets/progress_indicator.dart';

import '../../../features.dart';
import 'chapters_card_new.dart';

class CourseDetailTab extends StatefulWidget {
  const CourseDetailTab({
    super.key,
    required this.course,
    required this.completedChapters,
    required this.allChapters,
    required this.userChapterAnalysis,
    this.lastStartedSubChapterId,
  });

  final Course course;
  final int completedChapters;
  final int allChapters;
  final List<UserChapterAnalysis> userChapterAnalysis;
  final String? lastStartedSubChapterId;

  @override
  State<CourseDetailTab> createState() => _CourseDetailTabState();
}

class _CourseDetailTabState extends State<CourseDetailTab> {
  final _scrollBarController = ScrollController();
  final scrollDirection = Axis.vertical;
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    context
        .read<OfflineCourseBloc>()
        .add(IsCourseDownloadedEvent(courseId: widget.course.id));

    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(
        0,
        0,
        0,
        MediaQuery.of(context).padding.bottom,
      ),
      axis: scrollDirection,
    );

    if (widget.lastStartedSubChapterId != null) {
      for (int idx = 0; idx < widget.userChapterAnalysis.length; idx++) {
        if (widget.userChapterAnalysis[idx].chapter.id ==
            widget.lastStartedSubChapterId) {
          _scrollToLastStartedChapter(idx);
        }
      }
    }
  }

  Future _scrollToLastStartedChapter(int index) async {
    await controller.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
    controller.highlight(
      index,
      highlightDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OfflineCourseBloc, OfflineCourseState>(
      listener: (context, state) {
        if (state is DownloadCourseByIdLoaded) {
          context
              .read<OfflineCourseBloc>()
              .add(MarkCourseAsDownloadedEvent(courseId: widget.course.id));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Course Downloaded Successfully',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF187A6C),
            ),
          );
        }
        if (state is MarkCourseAsDownloadedLoaded) {
          context
              .read<OfflineCourseBloc>()
              .add(IsCourseDownloadedEvent(courseId: widget.course.id));
        }
      },
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3.h, right: 4.w, left: 4.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32.w,
                    height: 23.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                            widget.course.image.imageAddress,
                          )),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 23.h),
                        child: Scrollbar(
                          controller: _scrollBarController,
                          thumbVisibility: true,
                          thickness: 4,
                          child: SingleChildScrollView(
                            controller: _scrollBarController,
                            child: Text(
                              widget.course.description,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.visible,
                              // maxLines: 6,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            BlocBuilder<OfflineCourseBloc, OfflineCourseState>(
              builder: (context, state) {
                bool isCourseDownloaded = false;
                bool isLoading = false;
                if (state is IsCourseDownloadedLoaded) {
                  isCourseDownloaded = state.isCourseDownloaded;
                  isLoading = false;
                } else if (state is DownloadCourseByIdLoading) {
                  isLoading = true;
                } else if (state is DownloadCourseByIdLoading) {
                  isLoading = false;
                }
                return Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF18786a),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: isCourseDownloaded
                          ? null
                          : () {
                              context.read<OfflineCourseBloc>().add(
                                  DownloadCourseByIdEvent(
                                      courseId: widget.course.id));
                            },
                      child: isLoading
                          ? SizedBox(
                              height: 16,
                              width: 16,
                              child: LoadingIndicator(
                                indicatorType: Indicator.values[24],
                                colors: const [Colors.white],
                                strokeWidth: 4.0,
                                pathBackgroundColor: Colors.black45,
                              ),
                            )
                          : Text(
                              isCourseDownloaded
                                  ? AppLocalizations.of(context)!.downloaded
                                  : AppLocalizations.of(context)!.download,
                              style: GoogleFonts.poppins(),
                            ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.only(bottom: 4.h, right: 4.w, left: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.progress,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: .5.h),
                        decoration: BoxDecoration(
                          color: Color(widget.course.isNewCurriculum
                                  ? 0xff18786a
                                  : 0xffFEA800)
                              .withOpacity(.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.course.isNewCurriculum
                              ? AppLocalizations.of(context)!.new_key
                              : AppLocalizations.of(context)!.old,
                          style: TextStyle(
                            color: Color(widget.course.isNewCurriculum
                                    ? 0xff18786a
                                    : 0xffFEA800 //0xffFEA800
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 1.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: LinearProgressIndicator(
                      semanticsValue:
                          '${((widget.completedChapters / widget.allChapters) * 100).round()}%',
                      value: widget.completedChapters / widget.allChapters,
                      minHeight: 14,
                      backgroundColor: const Color(0xffDCE8F7),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xff3DB861),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                widget.userChapterAnalysis.length,
                (index) => AutoScrollTag(
                  key: ValueKey(index),
                  index: index,
                  controller: controller,
                  highlightColor: const Color(0xFF17686A).withOpacity(0.1),
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: 4.w, left: 4.w, bottom: 2.h),
                    child: ChapterCard(
                      index: index + 1,
                      userChapterAnalysis: widget.userChapterAnalysis[index],
                      course: widget.course,
                      lastStartedSubChapterId: widget.lastStartedSubChapterId,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
