import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/widgets/noInternet.dart';
import 'package:skill_bridge_mobile/core/widgets/tooltip_widget.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/widgets/contestsharecard.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/widgets/upcomingcontestcard.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/count_down_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/snack_bar.dart';

class ContestsMainPage extends StatefulWidget {
  const ContestsMainPage({super.key});

  @override
  State<ContestsMainPage> createState() => _ContestsMainPageState();
}

class _ContestsMainPageState extends State<ContestsMainPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int _tabIndex = 0;
  late Timer _timer;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });

    context.read<FetchLiveContestBloc>().add(FetchingLiveContestEvent());
    context.read<LiveContestBloc>().add(GetLiveContestEvent());
    context
        .read<FetchPreviousContestsBloc>()
        .add(const FetchPreviousContestsEvent());
    context
        .read<FetchPreviousUserContestsBloc>()
        .add(const FetchPreviousUserContestsEvent());
    context
        .read<FetchUpcomingUserContestBloc>()
        .add(FetchUpcomingContestEvent());
    context.read<GetUserBloc>().add(GetUserCredentialEvent());
    _timer = Timer.periodic(const Duration(seconds: 0), (timer) {});
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.contests,
            ),
            SizedBox(width: 2.w),
            TooltipWidget(
                iconSize: 20,
                message: AppLocalizations.of(context)!.contest_info),
          ],
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) => [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 0.h, left: 5.w, right: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    // height: 37.h,
                    constraints: BoxConstraints(
                      minHeight: 37.h, // Set your desired minimum height
                    ),
                    padding: EdgeInsets.only(
                        left: 4.w, right: 4.w, top: 2.h, bottom: .5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff2F92AF),
                          Color(0xff30377D),
                        ],
                      ),
                    ),
                    child: BlocListener<FetchUpcomingUserContestBloc,
                        FetchUpcomingUserContestState>(
                      listener: (context, state) {
                        if (state is UpcomingContestFailredState) {
                          if (state.failureType is RequestOverloadFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar(state.failureType.errorMessage));
                          }
                        }
                      },
                      child: BlocBuilder<FetchUpcomingUserContestBloc,
                          FetchUpcomingUserContestState>(
                        builder: (context, state) {
                          if (state is UpcomingContestFailredState) {
                            if (state.failureType is NetworkFailure) {
                              return NoInternet(
                                setColor: true,
                                reloadCallback: () {
                                  context
                                      .read<FetchUpcomingUserContestBloc>()
                                      .add(FetchUpcomingContestEvent());
                                },
                                // setColor: true,
                              );
                            }
                            return Center(
                              child: Text(AppLocalizations.of(context)!
                                  .something_is_not_right),
                            );
                          } else if (state is UpcomingContestLoadingState) {
                            return _contestTimerBoxShimmer();
                          } else if (state is UpcomingContestFetchedState) {
                            final contest = state.upcomingContes;
                            if (contest == null) {
                              // no contest available
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/noContest.png',
                                    height: 8.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    AppLocalizations.of(context)!.no_contest,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins'),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "${AppLocalizations.of(context)!.no_contest_text} 🌟",
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }
                            // contest available
                            return UpcomingContestCard(contest: contest);
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  const CustomContestCardWidget(
                    isForCreatingCustomContest: false,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    AppLocalizations.of(context)!.previous_contests,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            snap: false,
            collapsedHeight: 0,
            toolbarHeight: 0,
            elevation: 6,
            scrolledUnderElevation: 0,
            bottom: TabBar(
              indicatorColor:
                  _tabIndex == 0 ? Colors.redAccent : const Color(0xff18786a),
              labelColor: Colors.black,
              unselectedLabelStyle: const TextStyle(color: Colors.grey),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              tabAlignment: TabAlignment.fill,
              dividerHeight: 0,
              tabs: [
                Tab(
                  icon: const Icon(Icons.sensors_rounded, color: Colors.redAccent),
                  child: Text(
                    AppLocalizations.of(context)!.ongoing,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!.all_contests,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!.my_contests,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        body: Padding(
          padding: EdgeInsets.only(top: 2.w, left: 5.w, right: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocConsumer<FetchLiveContestBloc, FetchLiveContestState>(
                      builder: (context, state) {
                        if (state is FetchLiveContestLoading) {
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              return _contestLoadingShimmer();
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 2.h),
                            itemCount: 3,
                          );
                        } else if (state is FetchLiveContestLoaded) {
                          if (state.liveContests.isEmpty) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: EmptyListWidget(
                                  icon: 'assets/images/emptypage.svg',
                                  width: 100,
                                  height: 100,
                                  message: AppLocalizations.of(context)!
                                      .no_live_contest_available,
                                  reloadCallBack: () {
                                    context
                                        .read<FetchLiveContestBloc>()
                                        .add(
                                         FetchingLiveContestEvent());
                                  },
                                ),
                              ),
                            );
                          }
                          return ListView.separated(
                            itemBuilder: (context, index) => ContestListCard(
                              liveContest: state.liveContests[index],
                              isLiveContest: true,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemCount: state.liveContests.length,
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: EmptyListWidget(
                                icon: 'assets/images/emptypage.svg',
                                showImage: false,
                                message: AppLocalizations.of(context)!
                                    .check_your_internet_connection_and_try_again,
                                reloadCallBack: () {
                                  context
                                      .read<FetchLiveContestBloc>()
                                      .add(
                                      FetchingLiveContestEvent());
                                },
                              ),
                            ),
                          );
                        }
                      },
                      listener: (context, state) {},
                    ),
                    BlocListener<FetchPreviousContestsBloc,
                        FetchPreviousContestsState>(
                      listener: (context, state) {
                        if (state is FetchPreviousContestsFailed &&
                            state.failure is RequestOverloadFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBar(state.failure.errorMessage));
                        }
                      },
                      child: BlocBuilder<FetchPreviousContestsBloc,
                          FetchPreviousContestsState>(
                        builder: (context, state) {
                          if (state is FetchPreviousContestsLoading) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                return _contestLoadingShimmer();
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 2.h),
                              itemCount: 3,
                            );
                          } else if (state is FetchPreviousContestsLoaded) {
                            if (state.contests.isEmpty) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: EmptyListWidget(
                                    icon: 'assets/images/emptypage.svg',
                                    width: 100,
                                    height: 100,
                                    message: AppLocalizations.of(context)!
                                        .coming_soon_no_contests_here_yet,
                                    reloadCallBack: () {
                                      context
                                          .read<FetchPreviousContestsBloc>()
                                          .add(
                                              const FetchPreviousContestsEvent());
                                    },
                                  ),
                                ),
                              );
                            }
                            return RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<FetchPreviousContestsBloc>()
                                    .add(const FetchPreviousContestsEvent());
                              },
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return ContestListCard(
                                      contest: state.contests[index]);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 2.h),
                                itemCount: state.contests.length,
                              ),
                            );
                          } else {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: EmptyListWidget(
                                  icon: 'assets/images/emptypage.svg',
                                  showImage: false,
                                  message: AppLocalizations.of(context)!
                                      .check_your_internet_connection_and_try_again,
                                  reloadCallBack: () {
                                    context
                                        .read<FetchPreviousContestsBloc>()
                                        .add(
                                            const FetchPreviousContestsEvent());
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    BlocListener<FetchPreviousUserContestsBloc,
                        FetchPreviousUserContestsState>(
                      listener: (context, state) {
                        if (state is FetchPreviousUserContestsFailed &&
                            state.failure is RequestOverloadFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBar(state.failure.errorMessage));
                        }
                      },
                      child: BlocBuilder<FetchPreviousUserContestsBloc,
                          FetchPreviousUserContestsState>(
                        builder: (context, state) {
                          if (state is FetchPreviousUserContestsLoading) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                return _contestLoadingShimmer();
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 2.h),
                              itemCount: 3,
                            );
                          } else if (state is FetchPreviousUserContestsLoaded) {
                            if (state.contests.isEmpty) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: EmptyListWidget(
                                    icon: 'assets/images/emptypage.svg',
                                    width: 100,
                                    height: 100,
                                    message: AppLocalizations.of(context)!
                                        .you_have_not_registered_for_any_contests_yet,
                                    reloadCallBack: () {
                                      context
                                          .read<FetchPreviousUserContestsBloc>()
                                          .add(
                                              const FetchPreviousUserContestsEvent());
                                    },
                                  ),
                                ),
                              );
                            }
                            return RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<FetchPreviousUserContestsBloc>()
                                    .add(
                                        const FetchPreviousUserContestsEvent());
                              },
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return ContestListCard(
                                      contest: state.contests[index]);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 2.h),
                                itemCount: state.contests.length,
                              ),
                            );
                          } else {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: EmptyListWidget(
                                  icon: 'assets/images/emptypage.svg',
                                  showImage: false,
                                  message: AppLocalizations.of(context)!
                                      .check_your_internet_connection_and_try_again,
                                  reloadCallBack: () {
                                    context
                                        .read<FetchPreviousUserContestsBloc>()
                                        .add(
                                            const FetchPreviousUserContestsEvent());
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Shimmer _contestLoadingShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 3.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Shimmer _contestTimerBoxShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.black,
      highlightColor: Colors.white70,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 3.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  height: 3.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Container(
              height: 4.h,
              width: 50.w,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 5.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
