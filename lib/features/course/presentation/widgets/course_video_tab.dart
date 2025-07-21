import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/getVideoChannelsCubit/get_video_channels_cubit.dart';
import 'package:skill_bridge_mobile/core/utils/creat_links.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseVideoTab extends StatefulWidget {
  const CourseVideoTab({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  State<CourseVideoTab> createState() => _CourseVideoTabState();
}

class _CourseVideoTabState extends State<CourseVideoTab> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetVideoChannelsCubit>()
        .getVideoChannels(courseId: widget.courseId);
  }

  Future<void> _launchUrl(String urlString) async{
  if(await canLaunchUrl(Uri.parse(urlString))){
    await launchUrl(Uri.parse(urlString));
  }else{
    print("Can't launch url");
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: BlocBuilder<GetVideoChannelsCubit, GetVideoChannelsState>(
        builder: (context, state) {
          if (state is GetVideoChannelsLoadingState) {
            return _courseVideoTabShimmer();
          } else if (state is GetVideoChannelsFailedState) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else if (state is GetVideoChannelsLoadedState) {
            final channels = state.videoChannels;

            return ListView.separated(
                itemBuilder: (context, index) {
                  double covered = 0;
                  if (state.videoChannels[index].totalVideoCount != 0) {
                    covered = state.videoChannels[index].userAnalysisCount /
                        state.videoChannels[index].totalVideoCount;
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select Video Channel',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              'Select video channel of your preference',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          ChannelVideosPageRoute(
                                  channelId: channels[index].channelId,
                                  courseId: widget.courseId,
                                  channelName: channels[index].channelName,
                                  channelDescritption: channels[index].channelDescritption,
                                  channelUrl: channels[index].channelUrl,
                                  channelSubscribersCount: channels[index].channelSubscribersCount
                                  )
                              .go(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 2.5.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                color: Colors.black.withOpacity(0.05),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: channels[index].channelTumbnail,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: SizedBox(
                                      height: 75,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            channels[index].channelName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.person),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                state.videoChannels[index].channelSubscribersCount.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )
                                            ],
                                          )
                                        ]
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                    state.videoChannels[index].channelDescritption,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      height: 1.5,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w300
                                    ),
                                    ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: LinearProgressIndicator(
                                  // semanticsValue:
                                  //     '${((widget.completedChapters / widget.allChapters) * 100).round()}%',
                                  value: covered,
                                  minHeight: 8,
                                  backgroundColor: const Color(0xffDCE8F7),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xff18786a),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                  '${state.videoChannels[index].userAnalysisCount} / ${state.videoChannels[index].totalVideoCount} Videos Completed'
                                  ,style: TextStyle(fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                  ),
                              ),
                              SizedBox(height: 12,),
                              InkWell(
                                onTap: (){
                                  _launchUrl(state.videoChannels[index].channelUrl);
                                },
                                child: Row(children: [
                                  Image.asset('assets/images/youtubelogo.png',scale: 1.8,),
                                  SizedBox(width: 10,),
                                  Text('Visit Channel',style: TextStyle(fontFamily: 'Poppins',decoration: TextDecoration.underline,fontSize: 15,color: Color(0xff18786a),fontWeight: FontWeight.w500),),
                                  SizedBox(width: 10,),
                                  Icon(Icons.open_in_new_rounded,size: 18,color: Color(0xff18786a),)
                                ],),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 2.h),
                itemCount: channels.length);
          }

          return Column(
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(),
                // child: ChapterVideoWidget(chapterVideo: ,),
              ),
            ),
          );
        },
      ),
    );
  }

  Shimmer _courseVideoTabShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 45.w,
                          height: 2.5.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          width: 55.w,
                          height: 1.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          width: 16.w,
                          height: 2.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
            ),
          ],
        ),
      ),
    );
  }
}
