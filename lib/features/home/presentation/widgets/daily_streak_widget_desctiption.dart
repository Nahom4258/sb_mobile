import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/utils/same_day.dart';
import 'package:skill_bridge_mobile/core/widgets/tooltip_widget.dart';
import 'package:skill_bridge_mobile/features/home/domain/entities/user_daily_streak.dart';
import 'package:skill_bridge_mobile/features/home/presentation/bloc/fetch_daily_streak/fetch_daily_streak_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DailyStreakWidgetDesctiptionWidget extends StatelessWidget {
  const DailyStreakWidgetDesctiptionWidget({
    super.key,
    required this.userDailyStreakMap,
    required this.today,
    required this.setToday,
  });

  final Map<String, UserDailyStreak> userDailyStreakMap;
  final DateTime today;
  final Function setToday;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.daily_streak,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'),
                      ),
                      const SizedBox(width: 5.0,),
                      TooltipWidget(
            message: AppLocalizations.of(context)!.daily_streak_info,iconSize: 18.0,
          )
                    ],
                  ),
                  
                ],
              ),
              SizedBox(width: 1.w),
              Text(
                '| ${DateFormat('MMM dd').format(userDailyStreakMap['1']!.date)} - ${DateFormat('MMM dd').format(userDailyStreakMap['7']!.date)}',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF7D7D7D),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              if (!isSameDay(today, DateTime.now()))
                InkWell(
                  onTap: () {
                    setToday();
                    DateTime curr  = DateTime.now();
                    DateTime mondayBefore =
                        curr.subtract(Duration(days: today.weekday - 1));
                    DateTime sundayAfter =
                        curr.add(Duration(days: 7 - today.weekday));
                    context.read<FetchDailyStreakBloc>().add(
                        FetchDailyStreakEvent(
                            startDate: mondayBefore, endDate: sundayAfter));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF18786A).withOpacity(0.11),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.today,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF18786A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          BlocBuilder<FetchDailyStreakBloc, FetchDailyStreakState>(
              builder: (context, state) {
            if (state is FetchDailyStreakLoaded) {
              // return _maxStreakShimmer();
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  const Image(
                    image: AssetImage('assets/images/fireRed.png'),
                    height: 25,
                    width: 25,
                  ),
                  Text(
                    '${state.dailyStreak.totalStreak.maxStreak}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color(0xffF53A04),
                    ),
                  ),
                  // Here add small dropdown to select language. there are two languages available
                ],
              );
            } else {
              return Container();
            }
          }),
          
        ],
      ),
    );
  }
}
