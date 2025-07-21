import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/core/routes/go_routes.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/timeago.dart';

class FriendAcceptedNotification extends StatelessWidget {
  const FriendAcceptedNotification({
    super.key,
    required this.senderName,
    required this.senderAvatar,
    required this.reciverAvatar,
    required this.date,
    required this.receiverId,
  });
  final String senderName;
  final String senderAvatar;
  final String reciverAvatar;
  final DateTime date;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 33,
                width: 50,
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(senderAvatar),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(reciverAvatar),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 62.w,
                      child: InkWell(
                        onTap: () {
                          LeaderboardDetailPageRoute(userId: receiverId)
                              .go(context);
                        },
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'You and ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                  text: senderName,
                                  style: const TextStyle(
                                      color: Color(0xff1A7A6C),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                text: ' are now friends!',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          // textScaler: const TextScaler.linear(1.2),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
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
