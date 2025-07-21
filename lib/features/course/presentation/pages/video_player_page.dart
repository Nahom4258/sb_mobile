import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/course/domain/entities/subchapter_video.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/playerPageCubit/video_player_page_cubit.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({
    super.key,
    required this.videoLink,
    required this.chatersVideos,
  });

  final String videoLink;
  final List<SubchapterVideo> chatersVideos;
  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  late YoutubeMetaData _videoMetaData;
  bool isPaused = false;
  late String currentPlayingVideoLink;
  String videoTitle = '';
  @override
  void initState() {
    super.initState();
    _videoMetaData = const YoutubeMetaData();
    currentPlayingVideoLink = widget.videoLink;
    context
        .read<VideoPlayerPageCubit>()
        .setCurrentVideo(videoLink: widget.videoLink);
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    _controller.setFullScreenListener(
      (isFullScreen) {
        log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      },
    );
    setupListener();
    _controller.loadVideo(widget.videoLink);
  }

  void setupListener() {
    _controller.listen((data) {
      context
          .read<VideoPlayerPageCubit>()
          .setVideoTitle(videoTitle: data.metaData.title);
      context
          .read<VideoPlayerPageCubit>()
          .setVideoState(st: data.playerState.code);
      // setState(() {});
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
        backgroundColor: Colors.black87,
        controller: _controller,
        builder: (context, player) {
          return Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   leading: IconButton(
            //     onPressed: () {
            //       context.pop();
            //     },
            //     icon: const Icon(Icons.arrow_back_ios),
            //   ),
            // ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  player,   
                  Container(
                    
                    child: IconButton(
                                    onPressed: () {
                    context.pop();
                                    },
                                    icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                                  ),
                  ),
                  
                ]),
                SizedBox(height: 2.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<VideoPlayerPageCubit, VideoPlayerPageState>(
                        builder: (context, pageState) {
                          return Text(
                            pageState.videoTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: const Text(
                    'Chapter Videos',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.w, right: 4.w, top: 2.h),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          final videoLink =
                              widget.chatersVideos[index].videoLink;

                          _controller.loadVideo(videoLink);
                          // setState(() {
                          //   currentPlayingVideoLink = videoLink;
                          // });
                          context
                              .read<VideoPlayerPageCubit>()
                              .setCurrentVideo(videoLink: videoLink);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 1.h),
                          width: 100.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      color: const Color(0xff18786a)
                                          .withOpacity(.2),
                                      width: 80,
                                      height: 80,
                                      child: Image.network(
                                        widget
                                            .chatersVideos[index].thumbnailUrl,
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
                              const SizedBox(width: 16),
                              BlocBuilder<VideoPlayerPageCubit,
                                  VideoPlayerPageState>(
                                builder: (context, pageState) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              widget.chatersVideos[index].title,
                                              // 'Determinants of Matrices of Order 3',
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                widget.chatersVideos[index]
                                                    .duration,
                                                // '10 mins',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(width: 3.w),
                                              if (pageState.currentVideoLink ==
                                                  widget.chatersVideos[index]
                                                      .videoLink)
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  // child: LinearProgressIndicator()
                                                  child: LoadingIndicator(
                                                    indicatorType:
                                                        Indicator.values[32],
                                                    colors: const [
                                                      Color(0xff18786A)
                                                    ],
                                                    strokeWidth: 4.0,
                                                    pathBackgroundColor:
                                                        Colors.black45,
                                                    pause: pageState.isPlaying,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: .5.h,
                      ),
                      itemCount: widget.chatersVideos.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
