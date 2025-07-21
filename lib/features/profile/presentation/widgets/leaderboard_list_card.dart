import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/core.dart';

class LeaderboardListCard extends StatelessWidget {
  const LeaderboardListCard({
    super.key,
    required this.userData,
    required this.userId,
    required this.rank,
    required this.points,
    required this.imageUrl,
    required this.name,
    required this.index,
    required this.contestAttended,
    required this.maxStreak,
    this.isMyRank = false,
  });
  final String userId;
  final int rank;
  final int points;
  final bool userData;
  final String imageUrl;
  final String name;
  final int index;
  final int contestAttended;
  final int maxStreak;
  final bool isMyRank;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (isMyRank) {
          UpdatedProfilePageRoute().go(context);
          return;
        }
        LeaderboardDetailPageRoute(userId: userId).go(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          decoration: BoxDecoration(
            color: isMyRank
                ? const Color(0xffC7DFDC)
                : index % 2 == 0
                    ? const Color(0xffF7F7F7)
                    : Colors.white,
            borderRadius: isMyRank
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
                : null,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.05),
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //     offset: const Offset(3,
            //         0), // Increased offset to add more elevation on left and right sides
            //   ),
            // ],
          ),
          // selectedTileColor: const Color(0xffD1DFDD),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 2.w),
              SizedBox(
                child: Text(
                  rank.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Container(
                height: 6.h,
                width: 6.h,
                decoration: BoxDecoration(
                  color: const Color(0xff18786a).withOpacity(.3),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(imageUrl),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(width: 6.w),
                  Row(
                    children: [
                      Image.asset('assets/images/fireRed.png',
                          width: 14, height: 14),
                      SizedBox(width: 1.w),
                      Text(
                        '$maxStreak',
                        style: TextStyle(
                          color: userData
                              ? Colors.black87
                              : const Color(0xFF363636),
                          fontWeight: FontWeight.w500,
                          fontSize: userData ? 16 : 15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.emoji_events_rounded,
                          color: Colors.amber, size: 20),
                      SizedBox(width: 1.w),
                      Text(
                        '$contestAttended',
                        style: TextStyle(
                          color: userData
                              ? Colors.black87
                              : const Color(0xFF363636),
                          fontWeight: FontWeight.w500,
                          fontSize: userData ? 16 : 15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.star_rounded,
                          color: Colors.amber, size: 20),
                      SizedBox(width: 1.w),
                      Text(
                        '${points.toString()} pts',
                        style: TextStyle(
                          color: userData
                              ? Colors.black87
                              : const Color(0xFF363636),
                          fontWeight: FontWeight.w500,
                          fontSize: userData ? 16 : 15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
