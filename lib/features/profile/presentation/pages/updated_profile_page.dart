import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/utils/number_converter.dart';
import 'package:skill_bridge_mobile/core/routes/go_routes.dart';

import 'package:skill_bridge_mobile/core/widgets/noInternet.dart';
import 'package:skill_bridge_mobile/core/widgets/tooltip_widget.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/consistency_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_profile_entity_get.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/barChartBloc/bar_chart_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/consistancyBloc/consistancy_bloc_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/schoolInfoBloc/school_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_event.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_state.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userRefferalInfoCubit/user_refferal_info_cubit.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/cashout.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/conststency_tracking_calender_widget.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/friends_and_invite_card.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/linechart.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/updadted_profile_overview_widget.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/updated_profile_header.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/updated_profile_stat_card.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/updated_user_records.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/snack_bar.dart';

class UpdatedProfilePage extends StatefulWidget {
  const UpdatedProfilePage({super.key});

  @override
  State<UpdatedProfilePage> createState() => _UpdatedProfilePageState();
}

class _UpdatedProfilePageState extends State<UpdatedProfilePage> {
  int curYear = DateTime.now().year;
  // double _value = 0;
  double time = 2;
  // Timer? _timer;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(
      GetUserProfile(isRefreshed: true),
    );
    context.read<ConsistancyBlocBloc>().add(GetUserConsistencyDataEvent(
          year: curYear.toString(),
        ));
    context.read<SchoolBloc>().add(GetSchoolInformationEvent());
    context.read<BarChartBloc>().add(GetBarChartDataEvent());
    context.read<UserRefferalInfoCubit>().getUserRefferalInfo();
    // _startTimer();
  }

  @override
  void dispose() {
    // _timer?.cancel();
    super.dispose();
  }

  // void _startTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       time--;
  //       if (time == 0) {
  //         _timer?.cancel();
  //         setState(() {
  //           _value = 57;
  //         });
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20.0,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5.w, left: 7.w),
              child: Column(
                children: [
                  BlocBuilder<UserProfileBloc, UserProfileState>(
                    builder: (context, state) {
                      if (state is ProfileFailedState) {
                        return SizedBox(
                          height: 50.h,
                          child: Center(
                            child: NoInternet(reloadCallback: () {
                              BlocProvider.of<UserProfileBloc>(context).add(
                                GetUserProfile(isRefreshed: true),
                              );

                              context
                                  .read<ConsistancyBlocBloc>()
                                  .add(GetUserConsistencyDataEvent(
                                    year: curYear.toString(),
                                  ));
                              context
                                  .read<SchoolBloc>()
                                  .add(GetSchoolInformationEvent());
                            }),
                          ),
                        );
                      } else if (state is ProfileLoading) {
                        return _updatedProfilePageTopShimmer();
                      } else if (state is ProfileLoaded) {
                        final user = state.userProfile;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileHeader(
                              firstName: user.firstName,
                              lastName: user.lastName,
                              grade: user.grade,
                              avatar: user.profileImage,
                            ),
                            SizedBox(height: 3.h),
                            ProfileStatCards(user: user),
                            SizedBox(height: 2.h),
                            FriendsAndInviteCard(
                              userId: user.id,
                              friends: user.numberOfFriends,
                            ),
                            SizedBox(height: 3.h),
                            // const CashoutWidget(),
                            // SizedBox(height: 3.h),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.overview,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                // const TooltipWidget(
                                //     iconSize: 18,
                                //     message:
                                //         'Long message No quiz for the day. Check back tomorrow for a new challenge!'),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            OverviewWidget(
                              chapterNum: user.chaptersCompleted,
                              points: user.points.toDouble(),
                              questionsNum: user.questionsSolved,
                              topicsNum: user.topicsCompleted,
                            ),
                            SizedBox(height: 3.h),
                            // ReferalButton(
                            //   userId: user.id,
                            // ),
                          ],
                        );
                      }

                      return Container();
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text(
                  //       'You have got',
                  //       style: TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xff18786a),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 20),
                  //       child: AnimatedFlipCounter(
                  //         value: _value,
                  //         // Use "infix" to show a value between negative sign and number
                  //         infix: ' \$',
                  //         fractionDigits: 2,
                  //         duration: const Duration(milliseconds: 800),
                  //         wholeDigits: 8,
                  //         hideLeadingZeroes: true,
                  //         // Some languages like French use comma as decimal separator
                  //         decimalSeparator: '.',
                  //         thousandSeparator: ',',
                  //         padding: const EdgeInsets.all(8),
                  //         textStyle: TextStyle(
                  //           fontSize: 36,
                  //           fontWeight: FontWeight.bold,
                  //           letterSpacing: -8.0,
                  //           color: _value < 0 ? Colors.red : Colors.green,
                  //           shadows: const [
                  //             BoxShadow(
                  //               color: Colors.yellow,
                  //               offset: Offset(2, 4),
                  //               blurRadius: 4,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     const Text(
                  //       'coins',
                  //       style: TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xff18786a),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 3.h),
                  // const BarChartWithDesctiption(),
                  SizedBox(height: 3.h),
                  // const GraphDescription(
                  //   numOfUsers: '34 / 214 Users',
                  //   percent: '1400',
                  //   range: 'Overall Ranking',
                  //   title: 'Contest Rating',
                  // ),
                  // SizedBox(height: 3.h),
                  // SizedBox(height: 20.h, child: const LineChartWidget()),
                  BlocListener<ConsistancyBlocBloc, ConsistancyBlocState>(
                    listener: (context, state) {
                      if (state is ConsistancyFailedState) {
                        if (state.failureType is RequestOverloadFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBar(state.failureType.errorMessage));
                        }
                      }
                    },
                    child:
                        BlocBuilder<ConsistancyBlocBloc, ConsistancyBlocState>(
                      builder: (context, state) {
                        if (state is ConsistancyLoadingState) {
                          return _updatedProfilePageBottomShimmer();
                        } else if (state is ConsistancyFailedState) {
                          // return SizedBox(
                          //   height: 50.h,
                          //   child: Center(
                          //     child: NoInternet(reloadCallback: () {

                          //     }),
                          //   ),
                          // );
                        } else if (state is ConsistancyLoadedState) {
                          final consistencyData = state.consistencyData;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)!
                                              .consistency_chart,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      SizedBox(width: 2.w),
                                      const TooltipWidget(
                                          iconSize: 18,
                                          message:
                                              'Monitor and Visualize the total number of questions you solved and topics you completed each day.'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            final year =
                                                consistencyData[0][0].day.year -
                                                    1;
                                            context
                                                .read<ConsistancyBlocBloc>()
                                                .add(
                                                  GetUserConsistencyDataEvent(
                                                      year: year.toString()),
                                                );
                                          },
                                          icon: const Icon(
                                            Icons.keyboard_arrow_left,
                                          )),
                                      Text(consistencyData[0][0]
                                          .day
                                          .year
                                          .toString()),
                                      IconButton(
                                          onPressed: () {
                                            if (consistencyData[0][0]
                                                    .day
                                                    .year ==
                                                curYear) return;
                                            final year =
                                                consistencyData[0][0].day.year +
                                                    1;
                                            context
                                                .read<ConsistancyBlocBloc>()
                                                .add(
                                                    GetUserConsistencyDataEvent(
                                                        year: year.toString()));
                                          },
                                          icon: Icon(Icons.keyboard_arrow_right,
                                              color: consistencyData[0][0]
                                                          .day
                                                          .year ==
                                                      curYear
                                                  ? Colors.grey
                                                  : null))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              SizedBox(
                                height: 35.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  controller: ScrollController(
                                    initialScrollOffset:
                                        (DateTime.now().month * 20.w),
                                  ),
                                  itemBuilder: (context, index) {
                                    List<ConsistencyEntity> monthData =
                                        consistencyData[index];

                                    return ConsistencyTrackingCalenderWidget(
                                      month: months[index],
                                      numOfDays: monthData.length,
                                      consistencyData: monthData,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(width: 3.w);
                                  },
                                  itemCount: 12,
                                ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Shimmer _updatedProfilePageTopShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 2.5.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                    ),
                    SizedBox(height: .5.h),
                    Container(
                      height: 2.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
              const Icon(
                Icons.settings,
                color: Colors.white54,
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 26.w,
                height: 6.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
              ),
              Container(
                width: 30.w,
                height: 6.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
              ),
              Container(
                width: 26.w,
                height: 6.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      Container(
                          height: 3.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  height: 3.h,
                  width: 1,
                  color: Colors.white,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Container(
                      width: 40.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            width: 30.w,
            height: 3.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
          ),
          SizedBox(height: 2.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: UpdatedSingleRecordCard(
                        imageColor: Colors.orange,
                        imagePath: 'assets/images/Book.png',
                        number: 12,
                        text: 'Chapters Completed'),
                  ),
                  SizedBox(width: 2.w),
                  const Expanded(
                    child: UpdatedSingleRecordCard(
                        imageColor: Colors.purple,
                        imagePath: 'assets/images/Star.png',
                        number: 12,
                        text: 'Points'),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: UpdatedSingleRecordCard(
                        imageColor: Colors.grey,
                        imagePath: 'assets/images/Overview.png',
                        number: 12,
                        text: 'Topics Completed'),
                  ),
                  SizedBox(width: 2.w),
                  const Expanded(
                    child: UpdatedSingleRecordCard(
                        imageColor: Colors.green,
                        imagePath: 'assets/images/askQuestion.png',
                        number: 12,
                        text: 'Questions Solved'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }

  Shimmer _updatedProfilePageBottomShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 35.w,
                height: 2.5.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_left)),
                  Container(
                    width: 12.w,
                    height: 2.5.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_right))
                ],
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 35.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 3.w),
              itemCount: 3,
              itemBuilder: (context, index) => SizedBox(
                height: 27.h,
                width: 25.w,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    Color cellColor = Colors.white;

                    return Container(
                      height: 14,
                      width: 14,
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: cellColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileStatCards extends StatelessWidget {
  const ProfileStatCards({
    super.key,
    required this.user,
  });

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatCard(
            imageAsset: 'assets/images/fireRed.png',
            width: 26.w,
            number: user.maxStreak.toString(),
            title: AppLocalizations.of(context)!.streak_cap,
            isForPoint: false),
        StatCard(
            imageAsset: 'assets/images/Coin.png',
            width: 30.w,
            number: formatNumber(number: user.coins.ceil()),
            title: AppLocalizations.of(context)!.coins_cap,
            isForPoint: true),
        StatCard(
            imageAsset: 'assets/images/Rank.png',
            width: 26.w,
            number: user.rank.toString(),
            title: AppLocalizations.of(context)!.rank_cap,
            isForPoint: false),
      ],
    );
  }
}
