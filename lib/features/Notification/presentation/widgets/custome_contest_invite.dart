import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skill_bridge_mobile/core/routes/go_routes.dart';
import 'package:skill_bridge_mobile/core/utils/create_links.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/friend_invite_notification.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/timeago.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/bloc/get_user_bloc/get_user_bloc.dart';

class CustomeContestInvitationWidget extends StatefulWidget {
  const CustomeContestInvitationWidget(
      {super.key,
      required this.forRegisteredContest,
      required this.date,
      required this.contestDescription,
      required this.contestId,
      required this.invitedBy,
      required this.invitedById});
  final bool forRegisteredContest;
  final DateTime date;
  final String contestDescription;
  final String contestId;
  final String? invitedBy;
  final String? invitedById;

  @override
  State<CustomeContestInvitationWidget> createState() =>
      _CustomeContestInvitationWidgetState();
}

class _CustomeContestInvitationWidgetState
    extends State<CustomeContestInvitationWidget> {
  bool isShareInProgress = false;
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
                        AssetImage('assets/images/upcomingContestIcon.png'))),
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
                        child: InkWell(
                          onTap: () {
                            LeaderboardDetailPageRoute(
                                    userId: widget.invitedById!)
                                .go(context);
                          },
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.invitedBy,
                                  style: const TextStyle(
                                      color: Color(0xff1A7A6C),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: ' has invited you to a new contest!',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(width: 2.w),
                    TimeAgo(dateTime: widget.date),
                  ],
                ),
                // SizedBox(height: 1.5.h),
                // Row(
                //   mainAxisAlignment: widget.forRegisteredContest
                //       ? MainAxisAlignment.start
                //       : MainAxisAlignment.start,
                //   children: [
                //     if (!widget.forRegisteredContest)
                //       AcceptOrDeline(
                //         color: const Color(0xff18786a),
                //         onClick: () {
                //           ContestDetailPageRoute(id: widget.contestId)
                //               .go(context);
                //         },
                //         textColor: Colors.white,
                //         title: 'Register',
                //       ),
                //     if (!widget.forRegisteredContest) SizedBox(width: 3.w),
                //     AcceptOrDeline(
                //       color: Colors.white,
                //       onClick: () {
                //         final route = 'contest/${widget.contestId}';
                //         isShareInProgress = true;
                //         final userId = context.read<GetUserBloc>().state
                //                 is GetUserCredentialState
                //             ? (context.read<GetUserBloc>().state
                //                     as GetUserCredentialState)
                //                 .userCredential
                //                 ?.id
                //             : null;
                //         DynamicLinks.createDynamicLink(
                //           route: route,
                //           imageURL:
                //               'https://res.cloudinary.com/djrfgfo08/image/upload/v1719494765/SkillBridge/mobile_team_icons/hqwdfje4jjee3doxjlu7.jpg',
                //           description: widget.contestDescription,
                //           userId: userId,
                //         ).then((value) {
                //           setState(() {
                //             isShareInProgress = false;
                //           });
                //           Share.share(
                //             value,
                //             subject: 'SkillBridge contest',
                //           );
                //         });
                //       },
                //       textColor: Colors.black,
                //       title: isShareInProgress ? '...' : 'Invite Friends',
                //     ),
                //   ],
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
