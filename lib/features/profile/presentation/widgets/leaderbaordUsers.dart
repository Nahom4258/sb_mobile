import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/constants/app_enums.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/routes/go_routes.dart';
import 'package:skill_bridge_mobile/core/widgets/empty_list_widget.dart';
import 'package:skill_bridge_mobile/core/widgets/noInternet.dart';
import 'package:skill_bridge_mobile/core/widgets/session_expire_alert.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_leaderboard_entity.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/usersLeaderboard/users_leaderboard_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/leaderboard_list_card.dart';

class LeaderboardUsersList extends StatelessWidget {
  const LeaderboardUsersList({
    super.key,
    required this.currentPage,
  });
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersLeaderboardBloc, UsersLeaderboardState>(
      builder: (context, state) {
        if (state is UsersLeaderboardFailedState) {
          if (state.failure is NetworkFailure) {
            return SliverToBoxAdapter(
              child: NoInternet(
                reloadCallback: () {
                  context.read<UsersLeaderboardBloc>().add(
                        const GetTopUsersEvent(
                            pageNumber: 1,
                            leaderboardType: LeaderboardType.all_alltime),
                      );
                },
              ),
            );
          } 
          // else if (state.failure is AuthenticationFailure) {
          //   return const SliverToBoxAdapter(
          //       child: Center(child: SessionExpireAlert()));
          // }
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('Unkown Error happend'),
            ),
          );
        } else if (state is UsersLeaderboardLoadingState) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int _) {
                return _LeaderboardLoadingShimmer();
              },
              childCount: 6,
            ),
          );
        } else if (state is UsersLeaderboardLoadedState) {
          List<UserLeaderboardEntity> topUsers =
              state.topUsers.userLeaderboardEntities;
          if (topUsers.isEmpty) {
            return  SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Image.asset('assets/images/addfriends.png', width: 200,height: 200),
                  Text(
                    'Add more friends',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height:5),
                  Text(
                    'Leaderboards are more fun with friends!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 45.w,
                    child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF18786A),
                              minimumSize: Size(double.infinity, 5.8.h),
                            ),
                            onPressed: () {
                              return AddFriendspageRoute().go(context);
                              
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.group_add),
                                SizedBox(width: 10,),
                                const Text(
                                  'Add Friends',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ]
                )
            
            );
          }
          final users = state.topUsers;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return LeaderboardListCard(
                  userId: users.userLeaderboardEntities[index].userId,
                  index: index,
                  userData: false,
                  imageUrl: users.userLeaderboardEntities[index].userAvatar,
                  name:
                      '${users.userLeaderboardEntities[index].firstName} ${users.userLeaderboardEntities[index].lastName}',
                  points: users.userLeaderboardEntities[index].overallPoints
                      .toInt(),
                  rank: (currentPage - 1) * 10 +
                      4 +
                      index, // this implementation is dependent on the page size
                  contestAttended:
                      users.userLeaderboardEntities[index].contestAttended,
                  maxStreak: users.userLeaderboardEntities[index].maxStreak,
                );
              },
              childCount: users.userLeaderboardEntities.length,
            ),
          );
        }
        return SliverToBoxAdapter(
          child: Container(),
        );
      },
    );
  }
}

Shimmer _LeaderboardLoadingShimmer() {
  return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 1.h),
            Row(
              children: [
                SizedBox(width: 2.w),
                Container(
                  width: 5.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(width: 3.w),
                Container(
                  height: 6.h,
                  width: 6.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 2.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star),
                        SizedBox(width: 1.w),
                        Container(
                          height: 1.5.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ));
}
