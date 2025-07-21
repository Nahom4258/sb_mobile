import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LeaderboardTabs extends StatelessWidget {
  const LeaderboardTabs({
    super.key,
    required this.title,
    required this.isActive,
  });
  final String title;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      decoration: isActive
          ? BoxDecoration(
              color: const Color(0xff18786a),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 2,
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: Text(title),
    );
  }
}
