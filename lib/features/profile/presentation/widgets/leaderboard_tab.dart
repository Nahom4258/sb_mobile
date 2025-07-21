import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:skill_bridge_mobile/core/bloc/tokenSession/token_session_bloc.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/topThreeUsersLeaderboardBloc/users_leaderboard_bloc.dart';

import 'package:skill_bridge_mobile/features/profile/presentation/widgets/leaderboardtabs.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/nested_scrollLederboard_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/usersLeaderboard/users_leaderboard_bloc.dart';

class LeaderboardTab extends StatefulWidget {
  const LeaderboardTab({super.key});
  @override
  State<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double appBarExpandedHeight = 10;
  final scrollContoller = ScrollController();
  int currentPage = 1;
  int page = 1;
  final List<String> _options = ['All Time', 'Weekly', 'Monthly'];
  String _selectedOption = 'All Time';
  int currentTabIndex = 0;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  LeaderboardType getLeaderboardType({required int idx}) {
    switch (idx) {
      case 0:
        if (_selectedOption == 'All Time') {
          return LeaderboardType.all_alltime;
        } else if (_selectedOption == 'Weekly') {
          return LeaderboardType.all_weekly;
        }
        return LeaderboardType.all_monthly;
      case 1:
        if (_selectedOption == 'All Time') {
          return LeaderboardType.friends_alltime;
        } else if (_selectedOption == 'Weekly') {
          return LeaderboardType.friends_weekly;
        }
        return LeaderboardType.friends_monthly;
      case 2:
        if (_selectedOption == 'All Time') {
          return LeaderboardType.school_alltime;
        } else if (_selectedOption == 'Weekly') {
          return LeaderboardType.school_weekly;
        }
        return LeaderboardType.school_monthly;
      default:
        return LeaderboardType.all_alltime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TokenSessionBloc, TokenSessionState>(
      listener: (context, state) {
        if (state is TokenSessionExpiredState) {
          LoginPageRoute().go(context);
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 2.h),
            width: 100.w,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(24, 120, 106, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.leaderboard} 🏆',
                  style: TextStyle(
                    color: Colors.white,
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: .5.h),
                  child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelPadding: EdgeInsets.zero,
                        dividerColor: Colors.transparent,
                        indicatorColor: const Color(0xffF2F4F6),
                        indicatorPadding:
                            EdgeInsets.symmetric(horizontal: 10.w),
                        indicatorWeight: .001,
                        onTap: (index) {
                          if (index == currentTabIndex) return;
                          setState(() {
                            currentTabIndex = index;
                          });
                          context.read<TopThreeUsersBloc>().add(
                              GetTopThreeUsersEvent(
                                  pageNumber: 1,
                                  leaderboardType:
                                      getLeaderboardType(idx: index)));
                          context.read<UsersLeaderboardBloc>().add(
                              GetTopUsersEvent(
                                  pageNumber: 1,
                                  leaderboardType:
                                      getLeaderboardType(idx: index)));
                        },
                        tabs: [
                          LeaderboardTabs(
                            isActive: currentTabIndex == 0,
                            title: AppLocalizations.of(context)!.all_time,
                          ),
                          LeaderboardTabs(
                            isActive: currentTabIndex == 1,
                            title: AppLocalizations.of(context)!.friends,
                          ),
                          LeaderboardTabs(
                            isActive: currentTabIndex == 2,
                            title: AppLocalizations.of(context)!.school,
                          ),
                        ],
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xff3D3D3D),
                      )),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppLocalizations.of(context)!.filter,style: TextStyle(color: Colors.white,fontSize:15.0,fontFamily: 'Poppins'),),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: _selectedOption,
                        icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                        elevation: 16,
                        style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontSize:15.0,fontWeight: FontWeight.w600),
                        underline: Container(
                          height: 0.5,
                          color: Colors.white,
                        ),
                        dropdownColor: Colors.black38,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                          });
                          context.read<TopThreeUsersBloc>().add(
                              GetTopThreeUsersEvent(
                                  pageNumber: 1,
                                  leaderboardType:
                                      getLeaderboardType(idx: currentTabIndex)));
                          context.read<UsersLeaderboardBloc>().add(GetTopUsersEvent(
                              pageNumber: 1,
                              leaderboardType:
                                  getLeaderboardType(idx: currentTabIndex)));
                        },
                        items:
                            _options.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: NestedScrollableLeaderboardWidget(
              currentTabIndex: currentTabIndex,
            ),
          ),
        ],
      ),
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
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: ringSize,
              width: ringSize,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Container(
          height: 3.h,
          width: 30.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(height: 1.5.h),
        Container(
          height: 3.h,
          width: 12.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(height: 1.5.h),
        Container(
          height: 2.h,
          width: 25.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
        )
      ],
    );
  }
}
