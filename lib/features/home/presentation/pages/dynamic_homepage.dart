import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/utils/number_converter.dart';
import 'package:skill_bridge_mobile/core/widgets/tooltip_widget.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/carousel_slider.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/daily_streak_widget_desctiption.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/daily_streak_with_days_info.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/dynamic_homepage_header_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/homepage_stat_card.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userRefferalInfoCubit/user_refferal_info_cubit.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../../features.dart';

class DynamicHomePage extends StatefulWidget {
  const DynamicHomePage({super.key});

  @override
  State<DynamicHomePage> createState() => _DynamicHomePageState();
}

class _DynamicHomePageState extends State<DynamicHomePage> {
  List<String> days = [];
  DateTime today = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    days = [
      AppLocalizations.of(context)!.mon,
      AppLocalizations.of(context)!.tue,
      AppLocalizations.of(context)!.wed,
      AppLocalizations.of(context)!.thu,
      AppLocalizations.of(context)!.fri,
      AppLocalizations.of(context)!.satr,
      AppLocalizations.of(context)!.sun
    ];
  }

  @override
  void initState() {
    super.initState();
    DateTime mondayBefore = today.subtract(Duration(days: today.weekday - 1));
    DateTime sundayAfter = today.add(Duration(days: 7 - today.weekday));
    context.read<FetchDailyStreakBloc>().add(
        FetchDailyStreakEvent(startDate: mondayBefore, endDate: sundayAfter));
    context.read<HomeBloc>().add(const GetHomeEvent(refresh: true));
    context.read<FetchDailyQuizBloc>().add(const FetchDailyQuizEvent());
    context.read<GetUserBloc>().add(GetUserCredentialEvent());
    context.read<FetchDailyQuestBloc>().add(const FetchDailyQuestEvent());
    context
        .read<FetchUpcomingUserContestBloc>()
        .add(FetchUpcomingContestEvent());
    context.read<GetExamDateBloc>().add(ExamDateEvent());
    context.read<UserRefferalInfoCubit>().getUserRefferalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 3.h, right: 5.w, left: 5.w),
        child: Column(
          children: [
            DynamicHomepageProfileHeader(),
            SizedBox(height: 2.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // daily streak and announcement
                    Container(
                      alignment: Alignment.center,
                      // padding: EdgeInsets.only(
                      //     left: 2.5.w, right: 2.5, top: 2.h, bottom: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.black.withOpacity(.05)),
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: [
                        //   BoxShadow(
                        //     blurRadius: 10,
                        //     spreadRadius: 4,
                        //     color: Colors.black.withOpacity(.1),
                        //     offset: const Offset(1, 1),
                        //   ),
                        // ]
                      ),
                      child: BlocListener<FetchDailyStreakBloc,
                          FetchDailyStreakState>(
                        listener: (context, state) {
                          if (state is FetchDailyStreakFailed &&
                              state.failure is RequestOverloadFailure) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar(state.errorMessage));
                          }
                        },
                        child: Column(
                          children: [
                            //daily streak
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 2.5.w,
                                  right: 2.5.w,
                                  top: 2.h,
                                  bottom: 1.h),
                              child: BlocBuilder<FetchDailyStreakBloc,
                                  FetchDailyStreakState>(
                                builder: (context, state) {
                                  if (state is FetchDailyStreakLoading) {
                                    return _dailyStreakShimmer();
                                  } else if (state is FetchDailyStreakLoaded) {
                                    Map<String, UserDailyStreak>
                                        userDailyStreakMap = {};

                                    for (var userDailyStreak
                                        in state.dailyStreak.userDailyStreaks) {
                                      userDailyStreakMap[
                                              '${userDailyStreak.date.weekday}'] =
                                          userDailyStreak;
                                    }

                                    return Column(
                                      children: [
                                        DailyStreakWidgetDesctiptionWidget(
                                          userDailyStreakMap:
                                              userDailyStreakMap,
                                          today: today,
                                          setToday: () {
                                            setState(() {
                                              today = DateTime.now();
                                            });
                                          },
                                        ),
                                        DailyStreakWithDaysWidget(
                                          today: today,
                                          userDailyStreakMap:
                                              userDailyStreakMap,
                                          days: days,
                                          previousWeek: () {
                                            setState(() {
                                              today = today.subtract(
                                                  const Duration(days: 7));
                                            });
                                          },
                                          upcomingWeek: () {
                                            setState(() {
                                              today = today
                                                  .add(const Duration(days: 7));
                                            });
                                          },
                                        )
                                      ],
                                    );
                                  } 
                                  else if (state is FetchDailyStreakFailed) {
                                    // if (state.failure is AuthenticationFailure) {
                                    //   return const Center(child: SessionExpireAlert());
                                    // }
                                    return Center(
                                      child: EmptyListWidget(
                                        icon: 'assets/images/emptypage.svg',
                                        showImage: false,
                                        message: state.errorMessage,
                                        reloadCallBack: () {
                                          DateTime mondayBefore =
                                              today.subtract(Duration(
                                                  days: today.weekday - 1));
                                          DateTime sundayAfter = today.add(
                                              Duration(
                                                  days: 7 - today.weekday));
                                          context
                                              .read<FetchDailyStreakBloc>()
                                              .add(FetchDailyStreakEvent(
                                                  startDate: mondayBefore,
                                                  endDate: sundayAfter));
                                          context.read<HomeBloc>().add(
                                              const GetHomeEvent(
                                                  refresh: true));
                                          context
                                              .read<FetchDailyQuizBloc>()
                                              .add(const FetchDailyQuizEvent());
                                        },
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                            //rank and coin
                            Container(
                              padding: const EdgeInsets.only(top: 1),
                              decoration: const BoxDecoration(
                                  color: Color(0xffF1F1F1),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7.0),
                                      bottomRight: Radius.circular(7.0))),
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, homeState) {
                                  if (homeState is GetHomeState &&
                                      homeState.status == HomeStatus.loaded) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HomepageStatsCard(
                                          assetImage: 'assets/images/Rank.png',
                                          description:
                                              '/${homeState.totalUsers.toString()} '+AppLocalizations.of(context)!.students,
                                          stat: homeState.rank.toString(),
                                          title: AppLocalizations.of(context)!.rank,
                                          isLeft: true,
                                        ),
                                        const SizedBox(width: 1),
                                        HomepageStatsCard(
                                            title: AppLocalizations.of(context)!.coin,
                                            assetImage:
                                                'assets/images/Coin.png',
                                            description: AppLocalizations.of(context)!.coins_cap,
                                            stat: formatNumber(
                                                number: homeState.coins),
                                            isLeft: false),
                                      ],
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    SizedBox(
                      height: 15.h,
                      child: const CarouselSliderForUpcommingEvents(),
                    ),
                    SizedBox(height: 2.5.h),
                    //Continue Studying and Daily Quiz
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      left: 4.w, top: 3.h, bottom: 3.h),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff18786a),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: BlocBuilder<HomeBloc, HomeState>(
                                    builder: (context, state) {
                                      if (state is GetHomeState &&
                                          state.status == HomeStatus.loaded) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.lastStartedChapter == null
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .first_lesson
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .continue_studying,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(height: 1.h),
                                            Text(
                                              state.lastStartedChapter == null
                                                  ? ''
                                                  : state.lastStartedChapter!
                                                      .courseName,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                              maxLines: 1,
                                            ),
                                            SizedBox(height: 1.h),
                                            ConstrainedBox(
                                              // height: 5.h,
                                              constraints: BoxConstraints(
                                                  minHeight: 5.h),
                                              child: Text(
                                                state.lastStartedChapter == null
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .first_lesson_text
                                                    : state.lastStartedChapter!
                                                        .name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            InkWell(
                                              onTap: () {
                                                if (state.lastStartedChapter ==
                                                    null) {
                                                  ChooseSubjectPageRoute(
                                                          $extra: false)
                                                      .go(context);
                                                } else {
                                                  CourseDetailPageRoute(
                                                    courseId: state
                                                        .lastStartedChapter!
                                                        .courseId,
                                                    lastStartedSubChapterId:
                                                        state
                                                            .lastStartedChapter!
                                                            .id,
                                                  ).go(context);
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                    horizontal: 4.w),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      const Color(0xffffc107),
                                                ),
                                                child: Text(
                                                  state.lastStartedChapter ==
                                                          null
                                                      ? AppLocalizations.of(
                                                              context)!
                                                          .start
                                                      : AppLocalizations.of(
                                                              context)!
                                                          .continue_key,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      } else if (state is GetHomeState &&
                                          state.status == HomeStatus.loading) {
                                        return _continueStudyingShimmer();
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20)),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/images/stackOfBooks.png'),
                                      height: 8.h,
                                      width: 13.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Stack(
                            children: [
                              Container(
                                width: 35.w,
                                padding: EdgeInsets.only(
                                    right: 2.w,
                                    left: 4.w,
                                    top: 1.1.h,
                                    bottom: 2.h),
                                decoration: BoxDecoration(
                                    color: const Color(0xffffc107),
                                    borderRadius: BorderRadius.circular(20)),
                                child: BlocBuilder<FetchDailyQuizBloc,
                                    FetchDailyQuizState>(
                                  builder: (context, state) {
                                    if (state is FetchDailyQuizLoaded) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TooltipWidget(
                                                  iconSize: 18,
                                                  message: AppLocalizations.of(
                                                          context)!
                                                      .daily_quiz_info_revised),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .daily_quiz,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: Color(0xff263238),
                                                      fontSize: 18,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                            ],
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            state.dailyQuiz.dailyQuizQuestions
                                                    .isEmpty
                                                ? AppLocalizations.of(context)!
                                                    .no_quiz_for_the_day_check_back_tomorrow_for_a_new_challenge
                                                : state.dailyQuiz.isSolved !=
                                                            null &&
                                                        state
                                                            .dailyQuiz.isSolved!
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .enter_analysis_mode
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .daily_quiz_text,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          if (state.dailyQuiz.isSolved !=
                                                  null &&
                                              state.dailyQuiz.isSolved!)
                                            Text(
                                              '${AppLocalizations.of(context)!.score}: ${state.dailyQuiz.userScore}',
                                              style: TextStyle(
                                                color: const Color(0xff263238)
                                                    .withOpacity(.7),
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          SizedBox(height: 2.h),
                                          if (state.dailyQuiz.dailyQuizQuestions
                                              .isNotEmpty)
                                            InkWell(
                                              onTap: () {
                                                // print(
                                                //     'isSolved: ${state.dailyQuiz.isSolved}');
                                                if (state.dailyQuiz.isSolved!) {
                                                  context
                                                      .read<
                                                          FetchDailyQuizForAnalysisBloc>()
                                                      .add(
                                                        FetchDailyQuizForAnalysisByIdEvent(
                                                          id: state
                                                              .dailyQuiz.id,
                                                        ),
                                                      );
                                                } else {
                                                  DailyQuizQuestionPageRoute(
                                                    $extra:
                                                        DailyQuestionPageParams(
                                                      dailyQuiz:
                                                          state.dailyQuiz,
                                                      questionMode:
                                                          QuestionMode.quiz,
                                                      // context: context
                                                    ),
                                                  ).go(context);
                                                }
                                              },
                                              child: BlocBuilder<
                                                      FetchDailyQuizForAnalysisBloc,
                                                      FetchDailyQuizForAnalysisState>(
                                                  builder: (context,
                                                      fetchDailyQuizForAnalysisState) {
                                                // print(
                                                //     'Current state: $fetchDailyQuizForAnalysisState');
                                                if (fetchDailyQuizForAnalysisState
                                                    is FetchDailyQuizForAnalysisLoaded) {
                                                  DailyQuizQuestionPageRoute(
                                                    $extra:
                                                        DailyQuestionPageParams(
                                                      dailyQuiz:
                                                          fetchDailyQuizForAnalysisState
                                                              .dailyQuiz,
                                                      questionMode:
                                                          QuestionMode.analysis,
                                                      // context: context
                                                    ),
                                                  ).go(context);
                                                }
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.h,
                                                      horizontal: 4.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color:
                                                        const Color(0xff18786a),
                                                  ),
                                                  child: (fetchDailyQuizForAnalysisState
                                                          is FetchDailyQuizForAnalysisLoading)
                                                      ? const SizedBox(
                                                          height: 10,
                                                          width: 10,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 1,
                                                          ),
                                                        )
                                                      : Text(
                                                          (state.dailyQuiz.isSolved !=
                                                                      null &&
                                                                  state.dailyQuiz
                                                                          .isSolved ==
                                                                      false)
                                                              ? AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .go
                                                              : AppLocalizations
                                                                      .of(context)!
                                                                  .analysis,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                );
                                              }),
                                            )
                                        ],
                                      );
                                    } else if (state is FetchDailyQuizLoading) {
                                      return _dailyQuizShimmer();
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20)),
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/images/bookFloating.png'),
                                    height: 17.h,
                                    width: 20.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    // const StartStudySessionCard(),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.daily_quest,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: 2.w),
                        TooltipWidget(
                            iconSize: 20.0,
                            message: AppLocalizations.of(context)!
                                .daily_quest_info_revised)
                      ],
                    ),
                    const DailyQuestWidget(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Shimmer _dailyStreakShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 25.w,
                    height: 2.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  TooltipWidget(
                    message: AppLocalizations.of(context)!.daily_streak_info,
                  )
                  // const Text('('),
                  // Container(
                  //   width: 25.w,
                  //   height: 2.h,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                  // const Text(')'),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/fireGrey.png',
                    height: 25.0,
                    width: 25.0,
                  ),
                  const Text('1')
                ],
              ),
            ],
          ),
          SizedBox(
            width: 100.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.keyboard_arrow_left),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    height: 10.h,
                    child: ListView.separated(
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => Container(
                        width: 4.5.w,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 22),
                        child: Container(height: 1, color: Colors.white),
                      ),
                      itemBuilder: (context, index) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 23,
                            width: 23,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                          SizedBox(height: 1.5.h),
                          Container(
                            width: 18,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          // const Image(
                          //   image: AssetImage('assets/images/fireGrey.png'),
                          //   height: 25,
                          //   width: 25,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          )
        ],
      ),
    );
  }

  Shimmer _continueStudyingShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.black,
      highlightColor: const Color(0xffF9F8F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   'Continue Studying',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 20,
          //     fontFamily: 'Poppins',
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          Container(
            width: 120,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(height: 3.h),
          // const Text(
          //   'CHAPTER 2',
          //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          // ),
          Container(
            width: 48,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(height: 1.h),
          // const Text(
          //   'Organic molecules',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 16,
          //     fontFamily: 'Poppins',
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          Container(
            width: 100,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            width: 80,
            height: 32,
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
            ),
          )
        ],
      ),
    );
  }

  Shimmer _dailyQuizShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.black,
      highlightColor: const Color(0xffF9F8F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            width: 120,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black12,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            width: 80,
            height: 32,
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
            ),
          )
        ],
      ),
    );
  }
}
