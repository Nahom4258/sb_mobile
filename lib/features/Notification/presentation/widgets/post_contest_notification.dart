import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/timeago.dart';

class PostContestNotification extends StatelessWidget {
  const PostContestNotification({
    super.key,
  });

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
                    image: AssetImage('assets/images/congra.png'))),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 57.w,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '🎉 Congratulawtions, you finished 3rd on ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: 'Weekly Contest 21',
                              style: TextStyle(
                                  color: Color(0xff1A7A6C),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    TimeAgo(dateTime: DateTime.now()),
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
