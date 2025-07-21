import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/timeago.dart';

class ConsistencyNotifications extends StatelessWidget {
  const ConsistencyNotifications({super.key, required this.weeklyReportText, required this.date});
  final String weeklyReportText;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/weeklyProgressReport.png'))),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 62.w,
                      child: Text(
                        weeklyReportText,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    TimeAgo(dateTime: date),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
