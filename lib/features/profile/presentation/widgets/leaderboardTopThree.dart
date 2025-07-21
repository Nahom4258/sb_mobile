import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/constants/app_enums.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/widgets/empty_list_widget.dart';
import 'package:skill_bridge_mobile/core/widgets/noInternet.dart';
import 'package:skill_bridge_mobile/core/widgets/session_expire_alert.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_leaderboard_entity.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/topThreeUsersLeaderboardBloc/users_leaderboard_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/usersLeaderboard/users_leaderboard_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/top_ranked_detail_card.dart';

class LeaderboardTopThree extends StatelessWidget {
  const LeaderboardTopThree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF18786C),
      // pinned: true,
      // centerTitle: true,
      expandedHeight: 35.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          // height: 45.h,
          padding: EdgeInsets.only(bottom: 2.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                const Color(0xFF18786C).withOpacity(.8),
                const Color(0xff18786c),
              ],
            ),
          ),
          // padding: EdgeInsets.only(top: 2.h),
          child: BlocBuilder<TopThreeUsersBloc, TopThreeUsersState>(
              builder: (context, state) {
            if (state is TopThreeUsersFailedState) {
              if (state.failure is NetworkFailure) {
                return NoInternet(
                  reloadCallback: () {
                    context.read<TopThreeUsersBloc>().add(
                          const GetTopThreeUsersEvent(
                              pageNumber: 1,
                              leaderboardType: LeaderboardType.all_alltime),
                        );
                  },
                );
              } 
              // else if (state.failure is AuthenticationFailure) {
              //   return const Center(child: SessionExpireAlert());
              // }
              return const Center(
                child: Text('Unkown Error happend'),
              );
            } else if (state is TopThreeUsersLoadingState) {
              return _LeaderboardLoadingShimmer();
            } else if (state is TopThreeUsersLoadedState) {
              List<UserLeaderboardEntity> topUsers =
                  state.topUsers.userLeaderboardEntities;
              if (topUsers.isEmpty) {
                return Column(
                  children: [
                  Image.asset(
                    'assets/images/emptypagealt.png',
                    scale: 0.1,
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'Empty Leaderboard',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    "It seems there's no one on the leaderboard.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  )
                ]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  topUsers.length >= 2
                      ? TopRankedDetail(
                          userId: topUsers[1].userId,
                          diameter: 20.w,
                          color: const Color(0xff1C85E8),
                          badgeDiameter: 3.h,
                          rank: 2,
                          imageUrl: topUsers[1].userAvatar,
                          name:
                              '${topUsers[1].firstName} ${topUsers[1].lastName}',
                          point: topUsers[1].overallPoints.toInt(),
                          maxStreak: topUsers[1].maxStreak,
                          numberOfContestAttended: topUsers[1].contestAttended,
                        )
                      : Expanded(
                          child: Container(),
                        ),
                  topUsers.length >= 1
                      ? TopRankedDetail(
                          userId: topUsers[0].userId,
                          diameter: 24.w,
                          color: const Color(0xffFFC107),
                          // color: const Color(0xffFFC107),
                          badgeDiameter: 4.h,
                          rank: 1,
                          imageUrl: topUsers[0].userAvatar,
                          name:
                              '${topUsers[0].firstName} ${topUsers[0].lastName}',
                          point: topUsers[0].overallPoints.toInt(),
                          maxStreak: topUsers[0].maxStreak,
                          numberOfContestAttended: topUsers[0].contestAttended,
                        )
                      : Expanded(
                          child: Container(),
                        ),
                  topUsers.length >= 3
                      ? TopRankedDetail(
                          userId: topUsers[2].userId,
                          diameter: 20.w,
                          color: const Color(0xffF7A9A0),
                          badgeDiameter: 3.h,
                          rank: 3,
                          imageUrl: topUsers[2].userAvatar,
                          name:
                              '${topUsers[2].firstName} ${topUsers[2].lastName}',
                          point: topUsers[2].overallPoints.toInt(),
                          maxStreak: topUsers[2].maxStreak,
                          numberOfContestAttended: topUsers[2].contestAttended,
                        )
                      : Expanded(
                          child: Container(),
                        ),
                ],
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
}

Shimmer _LeaderboardLoadingShimmer() {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ltr,
    baseColor: Colors.black,
    highlightColor: const Color(0xffF9F8F8),
    child: Column(children: [
      SizedBox(height: 4.h),
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LeaderboardShimmer(size: 80, ringSize: 20),
              LeaderboardShimmer(size: 120, ringSize: 25),
              LeaderboardShimmer(size: 90, ringSize: 22),
            ],
          ),
        ],
      ),
    ]),
  );
}

Column LeaderboardShimmer({required double size, required double ringSize}) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: EdgeInsets.only(top: 2.h),
            child: Container(
              height: size,
              width: size,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
            ),
          ),
          Container(
            height: ringSize,
            width: ringSize,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black12),
          ),
        ],
      ),
      SizedBox(height: 1.h),
      Container(
        height: 3.h,
        width: 30.w,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      ),
      SizedBox(height: 1.5.h),
      Container(
        height: 3.h,
        width: 12.w,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      ),
      SizedBox(height: 1.5.h),
      Container(
        height: 2.h,
        width: 25.w,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      )
    ],
  );
}
