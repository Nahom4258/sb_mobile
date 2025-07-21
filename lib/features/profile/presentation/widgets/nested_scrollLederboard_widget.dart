import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:skill_bridge_mobile/core/constants/app_enums.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_leaderboard_rank.dart';

import 'package:skill_bridge_mobile/features/profile/presentation/bloc/usersLeaderboard/users_leaderboard_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/leaderbaordUsers.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/leaderboardTopThree.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/leaderboard_list_card.dart';

class NestedScrollableLeaderboardWidget extends StatefulWidget {
  final int currentTabIndex;
  const NestedScrollableLeaderboardWidget({
    super.key,
    required this.currentTabIndex,
  });

  @override
  State<NestedScrollableLeaderboardWidget> createState() =>
      _NestedScrollableLeaderboardWidgetState();
}

class _NestedScrollableLeaderboardWidgetState
    extends State<NestedScrollableLeaderboardWidget> {
  int numberOfPage = 1;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
  }

  LeaderboardType getLeaderboardType({required int idx}) {
    switch (idx) {
      case 0:
        return LeaderboardType.all_alltime;
      case 1:
        return LeaderboardType.friends_alltime;
      case 2:
        return LeaderboardType.school_alltime;
      default:
        return LeaderboardType.all_alltime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersLeaderboardBloc, UsersLeaderboardState>(
      listener: (context, state) {
        if (state is UsersLeaderboardLoadedState) {
          setState(() {
            numberOfPage = state.topUsers.numberofPages;
            currentPage = state.topUsers.currentPage;
          });
        }
      },
      child: NestedScrollView(
        // controller: scrollContoller,
        // physics: const BouncingScrollPhysics(parent: FixedExtentScrollPhysics()),

        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const LeaderboardTopThree(),
            BlocBuilder<UsersLeaderboardBloc, UsersLeaderboardState>(
              builder: (context, state) {
                if (state is UsersLeaderboardLoadedState &&
                    state.topUsers.userRank != null) {
                  UserLeaderboardRank userRank = state.topUsers.userRank!;
                  return SliverAppBar(
                    // shadowColor: const Color(0xff18786a),
                    pinned: true,
                    collapsedHeight: 10.h,
                    flexibleSpace: Stack(
                      children: [
                        Column(children: [
                          Expanded(
                            child: Container(
                              color: const Color(0xff18786a),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ]),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: LeaderboardListCard(
                            userId: userRank.id,
                            index: userRank.rank,
                            userData: false,
                            imageUrl: userRank.avatar,
                            name: '${userRank.firstName} ${userRank.lastName}',
                            points: userRank.points,
                            rank: userRank.rank,
                            contestAttended: userRank.contestAttended,
                            maxStreak: userRank.maxStreak,
                            isMyRank: true,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              },
            ),
          ];
        },
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            LeaderboardUsersList(currentPage: currentPage,),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
              sliver: SliverToBoxAdapter(
                child: paginationWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget paginationWidget() {
    List<Widget> pages = [];

    if (numberOfPage <= 1) return const SizedBox.shrink();
    pages.add(
      navigationButton(
        label: '<',
        page: currentPage > 1 ? currentPage - 1 : 1,
      ),
    );
    if (numberOfPage <= 7) {
      for (int i = 1; i <= numberOfPage; i++) {
        pages.add(pageButton(page: i));
      }
    } else {
      if (currentPage <= 2) {
        pages.add(pageButton(page: 1));
        pages.add(pageButton(page: 2));
        pages.add(pageButton(page: 3));
        pages.add(pageButton(page: 4));
        pages.add(ellipsis());
        pages.add(pageButton(page: numberOfPage - 1));
        pages.add(pageButton(page: numberOfPage));
      } else if (currentPage > 2 && currentPage < numberOfPage - 1) {
        pages.add(pageButton(page: 1));
        pages.add(ellipsis());
        pages.add(pageButton(page: currentPage - 1));
        pages.add(pageButton(page: currentPage));
        pages.add(pageButton(page: currentPage + 1));
        pages.add(ellipsis());
        pages.add(pageButton(page: numberOfPage));
      } else if (currentPage >= numberOfPage - 1) {
        pages.add(pageButton(page: 1));
        pages.add(pageButton(page: 2));
        pages.add(ellipsis());
        pages.add(pageButton(page: numberOfPage - 3));
        pages.add(pageButton(page: numberOfPage - 2));
        pages.add(pageButton(page: numberOfPage - 1));
        pages.add(pageButton(page: numberOfPage));
      }
    }
    pages.add(
      navigationButton(
        label: '>',
        page: currentPage < numberOfPage ? currentPage + 1 : numberOfPage,
      ),
    );

    return Row(
      children: pages,
    );
  }

  Widget pageButton({required int page}) {
    return GestureDetector(
      onTap: () {
        context.read<UsersLeaderboardBloc>().add(GetTopUsersEvent(
            pageNumber: page,
            leaderboardType: getLeaderboardType(idx: widget.currentTabIndex)));
        setState(() {
          currentPage = page;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: 30,
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: currentPage == page
              ? const Color(0xff18786a)
              : const Color(0xffE4E4E4),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: currentPage == page ? Colors.white : Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget navigationButton({required String label, required int page}) {
    return GestureDetector(
      onTap: () {
        if (currentPage == 1 && label == '<' ||
            currentPage == numberOfPage && label == '>') {
          return;
        }
        context.read<UsersLeaderboardBloc>().add(GetTopUsersEvent(
            pageNumber: label == '<' ? currentPage - 1 : currentPage + 1,
            leaderboardType: getLeaderboardType(idx: widget.currentTabIndex)));
        setState(() {
          currentPage = page;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: 30,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xffE4E4E4),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: (currentPage == 1 && label == '<' ||
                      currentPage == numberOfPage && label == '>')
                  ? const Color(0xff18786a).withOpacity(.5)
                  : const Color(0xff18786a),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget ellipsis() {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: const Text('...',
          style: TextStyle(
              color: Color(0xff18786a),
              fontWeight: FontWeight.bold,
              fontSize: 20)),
    );
  }
}
