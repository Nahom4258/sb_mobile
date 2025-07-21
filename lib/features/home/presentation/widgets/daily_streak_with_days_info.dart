import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/utils/same_day.dart';
import 'package:skill_bridge_mobile/features/home/domain/entities/user_daily_streak.dart';
import 'package:skill_bridge_mobile/features/home/presentation/bloc/fetch_daily_streak/fetch_daily_streak_bloc.dart';

class DailyStreakWithDaysWidget extends StatelessWidget {
   DailyStreakWithDaysWidget({
    super.key,
    required this.today,
    required this.userDailyStreakMap,
    required this.days,
    required this.previousWeek,
    required this.upcomingWeek,
  });

  late DateTime today;
  final Map<String, UserDailyStreak> userDailyStreakMap;
  final List<String> days;
  final Function previousWeek;
  final Function upcomingWeek;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 2.w),
          child: InkWell(
            onTap: () {
              previousWeek();
              today = today.subtract(const Duration(days: 7));
              DateTime mondayBefore =
                  today.subtract(Duration(days: today.weekday - 1));
              DateTime sundayAfter =
                  today.add(Duration(days: 7 - today.weekday));
              debugPrint(mondayBefore.toString() + "    " + sundayAfter.toString());
              context.read<FetchDailyStreakBloc>().add(FetchDailyStreakEvent(
                  startDate: mondayBefore, endDate: sundayAfter));
            },
            child: const Icon(Icons.keyboard_arrow_left),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 10.h,
            child: ListView.separated(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => Container(
                width: 5.5.w,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 3.h),
                child: Container(height: 1, color: const Color(0xffECECEC)),
              ),
              // separatorBuilder: (context, index) => SizedBox(width: 5.w),
              itemBuilder: (context, index) => StreakSingleDayCard(
                userDailyStreakMap: userDailyStreakMap,
                days: days,
                index: index,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: isSameDay(today, DateTime.now())
              ? null
              : () {
                  upcomingWeek();
                  today = today.add(const Duration(days: 7));
                  DateTime mondayBefore =
                      today.subtract(Duration(days: today.weekday - 1));
                  DateTime sundayAfter =
                      today.add(Duration(days: 7 - today.weekday));
                  debugPrint(mondayBefore.toString() + "    " + sundayAfter.toString());
                  context.read<FetchDailyStreakBloc>().add(
                      FetchDailyStreakEvent(
                          startDate: mondayBefore, endDate: sundayAfter));
                },
          child: isSameDay(today, DateTime.now())? const Icon(Icons.keyboard_arrow_right,color: Colors.black26,) : const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}

class StreakSingleDayCard extends StatelessWidget {
  const StreakSingleDayCard({
    super.key,
    required this.userDailyStreakMap,
    required this.days,
    required this.index,
  });

  final Map<String, UserDailyStreak> userDailyStreakMap;
  final List<String> days;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   days[index],
        //   style: const TextStyle(
        //       fontSize: 11,
        //       fontFamily: 'Poppins',
        //       fontWeight: FontWeight.w300),
        // ),
        // SizedBox(height: 1.h),
        // Image(
        //     image: userDailyStreakMap['${index + 1}']!.activeOnDay
        //         ? const AssetImage('assets/images/fireRed.png')
        //         : const AssetImage('assets/images/fireGrey.png'),
        //     height: 25,
        //     width: 25),
        Container(
          alignment: Alignment.center,
          height: 23,
          width: 23,
          decoration: BoxDecoration(
            color: userDailyStreakMap['${index + 1}']!.activeOnDay
                ? const Color(0xff42af75)
                : Colors.white,
            shape: BoxShape.circle,
            border: userDailyStreakMap['${index + 1}']!.activeOnDay
                ? null
                : Border.all(
                    color: const Color(0xffDBDBDB),
                    width: 1.5,
                  ),
          ),
          child: const Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 16,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          days[index],
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color: Color(0xffC0C0C0),
          ),
        ),
      ],
    );
  }
}
