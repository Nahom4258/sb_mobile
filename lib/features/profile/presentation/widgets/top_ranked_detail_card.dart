import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/top_ranked_profiles.dart';

class TopRankedDetail extends StatelessWidget {
  const TopRankedDetail({
    super.key,
    required this.diameter,
    required this.color,
    required this.userId,
    required this.badgeDiameter,
    required this.rank,
    required this.imageUrl,
    required this.name,
    required this.point,
    required this.maxStreak,
    required this.numberOfContestAttended,
  });
  final String userId;
  final double diameter;
  final Color color;
  final double badgeDiameter;
  final int rank;
  final String imageUrl;
  final String name;
  final int point;
  final int maxStreak;
  final int numberOfContestAttended;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: rank == 1 ? 3.h : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TopRankedProfiles(
              userId: userId,
              diameter: diameter,
              color: color,
              badgeDiameter: badgeDiameter,
              rank: rank,
              imageUrl: imageUrl),
          SizedBox(height: 1.h),
          SizedBox(
            width: 30.w,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: .5.h),
          Row(
            children: [
              Text(
                point.toString(),
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
               const Text(
            ' pts',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
            ],
          ),
         
          SizedBox(height: .5.h),
          Row(
            children: [
              Image.asset('assets/images/fireRed.png', width: 14, height: 14),
              SizedBox(width: 1.w),
              Text(
                maxStreak.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.emoji_events_rounded,
                  color: Colors.amber, size: 20),
              SizedBox(width: 1.w),
              Text(
                numberOfContestAttended.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
