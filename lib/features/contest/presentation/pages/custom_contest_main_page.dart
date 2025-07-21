import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../core/core.dart';

class CustomContestMainPage extends StatefulWidget {
  const CustomContestMainPage({super.key});

  @override
  State<CustomContestMainPage> createState() => _CustomContestMainPageState();
}

class _CustomContestMainPageState extends State<CustomContestMainPage>  with TickerProviderStateMixin{
  var _tabIndex = 0;
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener((){
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    context.read<FetchPreviousCustomContestBloc>().add(const FetchPreviousCustomContestEvent());
    context.read<FetchCustomContestInvitationsBloc>().add(const FetchCustomContestInvitationsEvent());
    context.read<FetchUpcomingCustomContestBloc>().add(const FetchUpcomingCustomContestEvent());
  }

  @override
  void dispose() {
    _tabController.removeListener((){});
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        // leading: IconButton(
        //   onPressed: (){
        //     context.pop();
        //   },
        //   icon: const Icon(Icons.arrow_back),
        // ),
        title: Text(
          AppLocalizations.of(context)!.custom_contests,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TabBar(
              controller: _tabController,
              labelPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              indicatorColor: const Color(0xffF2F4F6),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
              indicatorWeight: .001,
              tabs: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      bottomLeft: const Radius.circular(10),
                      topRight: Radius.circular(_tabIndex == 0 ? 10 : 0),
                      bottomRight: Radius.circular(_tabIndex == 0 ? 10 : 0),
                    ),
                    color: _tabIndex == 0
                        ? const Color(0xff18786a)
                        : const Color(0xFFF2F4F6),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.upcoming,
                    style: TextStyle(
                        color: _tabIndex == 0 ? Colors.white : Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        _tabIndex == 1 ? 10 : 0,),
                    color: _tabIndex == 1
                        ? const Color(0xff18786a)
                        : const Color(0xFFF2F4F6),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.invitations,
                    style: TextStyle(
                        color: _tabIndex == 1 ? Colors.white : Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: const Radius.circular(10),
                      bottomRight: const Radius.circular(10),
                      topLeft:  Radius.circular(_tabIndex == 2 ? 10 : 0),
                      bottomLeft:  Radius.circular(_tabIndex == 2 ? 10 : 0),
                    ),
                    color: _tabIndex == 2
                        ? const Color(0xff18786a)
                        : const Color(0xFFF2F4F6),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.all_contests,
                    style: TextStyle(
                        color: _tabIndex == 2 ? Colors.white : Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: CustomContestCardWidget(isForCreatingCustomContest: true),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BlocConsumer<FetchUpcomingCustomContestBloc, FetchUpcomingCustomContestState>(
                  listener: (BuildContext context, FetchUpcomingCustomContestState state) {  },
                  builder: (BuildContext context, FetchUpcomingCustomContestState state) {
                    if(state is FetchUpcomingCustomContestLoading) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return _contestLoadingShimmer();
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                        itemCount: 3,
                      );
                    } else if(state is FetchUpcomingCustomContestLoaded) {
                      List<CustomContest> upcomingCustomContests = state.upcomingCustomContests;
                      if(upcomingCustomContests.isEmpty) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: EmptyListWidget(
                              icon: 'assets/images/emptypage.svg',
                              width: 100,
                              height: 100,
                              message: AppLocalizations.of(context)!
                                  .no_custom_contest_available,
                              reloadCallBack: () {
                                context
                                    .read<FetchUpcomingCustomContestBloc>()
                                    .add(
                                    const FetchUpcomingCustomContestEvent());
                              },
                            ),
                          ),
                        );
                      }
                      upcomingCustomContests.sort((a,b) => b.startsAt.compareTo(a.startsAt));
                      return ListView.separated(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        itemCount: upcomingCustomContests.length,
                        itemBuilder: (context, index) => CustomContestListCard(
                          customContest: upcomingCustomContests[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: EmptyListWidget(
                            icon: 'assets/images/emptypage.svg',
                            message: AppLocalizations.of(context)!
                                .check_your_internet_connection_and_try_again,
                            reloadCallBack: () {
                              context
                                  .read<FetchUpcomingCustomContestBloc>()
                                  .add(
                                  const FetchUpcomingCustomContestEvent());
                            },
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                BlocConsumer<FetchCustomContestInvitationsBloc, FetchCustomContestInvitationsState>(
                  listener: (BuildContext context, FetchCustomContestInvitationsState state) {  },
                  builder: (BuildContext context, FetchCustomContestInvitationsState state) {
                    if(state is FetchCustomContestInvitationsLoading) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return _contestLoadingShimmer();
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                        itemCount: 3,
                      );
                    } else if(state is FetchCustomContestInvitationsLoaded) {
                      List<CustomContest> customContestInvitations = state.customContestInvitations;
                      if(customContestInvitations.isEmpty) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: EmptyListWidget(
                              icon: 'assets/images/emptypage.svg',
                              width: 100,
                              height: 100,
                              message: AppLocalizations.of(context)!
                                  .no_custom_contest_invitations_available,
                              reloadCallBack: () {
                                context
                                    .read<FetchCustomContestInvitationsBloc>()
                                    .add(
                                    const FetchCustomContestInvitationsEvent());
                              },
                            ),
                          ),
                        );
                      }
                      customContestInvitations.sort((a,b) => b.startsAt.compareTo(a.startsAt));
                      return ListView.separated(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        itemCount: customContestInvitations.length,
                        itemBuilder: (context, index) => CustomContestListCard(
                          isContestInvite: true,
                          customContest: customContestInvitations[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
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
                                  .read<FetchCustomContestInvitationsBloc>()
                                  .add(
                                  const FetchCustomContestInvitationsEvent());
                            },
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                BlocConsumer<FetchPreviousCustomContestBloc, FetchPreviousCustomContestState>(
                  listener: (BuildContext context, FetchPreviousCustomContestState state) {  },
                  builder: (BuildContext context, FetchPreviousCustomContestState state) {
                    if(state is FetchPreviousCustomContestLoading) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return _contestLoadingShimmer();
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                        itemCount: 3,
                      );
                    } else if(state is FetchPreviousCustomContestLoaded) {
                      List<CustomContest> previousCustomContests = state.previousCustomContests;
                      if(previousCustomContests.isEmpty) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: EmptyListWidget(
                              icon: 'assets/images/emptypage.svg',
                              width: 100,
                              height: 100,
                              message: AppLocalizations.of(context)!
                                  .no_custom_contest_available,
                              reloadCallBack: () {
                                context
                                    .read<FetchPreviousCustomContestBloc>()
                                    .add(
                                    const FetchPreviousCustomContestEvent());
                              },
                            ),
                          ),
                        );
                      }
                      previousCustomContests.sort((a,b) => b.startsAt.compareTo(a.startsAt));
                      return ListView.separated(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        itemCount: previousCustomContests.length,
                        itemBuilder: (context, index) => CustomContestListCard(
                          customContest: previousCustomContests[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
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
                                  .read<FetchPreviousCustomContestBloc>()
                                  .add(
                                  const FetchPreviousCustomContestEvent());
                            },
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ],
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

}
