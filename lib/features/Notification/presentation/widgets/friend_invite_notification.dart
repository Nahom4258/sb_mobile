import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/timeago.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/acceptOrRejectCubit/accept_or_reject_friend_reques_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendInviteNotification extends StatelessWidget {
  const FriendInviteNotification({
    super.key,
    required this.senderName,
    required this.senderAvatar,
    required this.date,
    required this.requestId,
  });
  final String senderName;
  final String senderAvatar;
  final DateTime date;
  final String requestId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(senderAvatar),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 57.w,
                      child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: senderName,
                              style: const TextStyle(
                                  color: Color(0xff1A7A6C),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: ' wants to be your friend.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    TimeAgo(dateTime: date),
                  ],
                ),
                SizedBox(height: 1.5.h),
                BlocBuilder<AcceptOrRejectFriendRequesCubit,
                    AcceptOrRejectFriendRequesState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AcceptOrDeline(
                          color: const Color(0xff18786a),
                          onClick: () {
                            context
                                .read<AcceptOrRejectFriendRequesCubit>()
                                .acceptFriendRequest(requestId: requestId);
                          },
                          textColor: Colors.white,
                          title: AppLocalizations.of(context)!.accept,
                        ),
                        SizedBox(width: 3.w),
                        AcceptOrDeline(
                          color: Colors.white,
                          onClick: () {
                            context
                                .read<AcceptOrRejectFriendRequesCubit>()
                                .rejectFriendRequest(requestId: requestId);
                          },
                          textColor: Colors.black,
                          title: AppLocalizations.of(context)!.decline,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AcceptOrDeline extends StatelessWidget {
  const AcceptOrDeline({
    super.key,
    required this.color,
    required this.title,
    required this.onClick,
    required this.textColor,
  });
  final Color color;
  final String title;
  final Color textColor;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 5.5.h,
        width: 32.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          
          border: Border.all(color: Colors.black.withOpacity(0.08)),
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
