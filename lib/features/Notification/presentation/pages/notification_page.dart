import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/core/widgets/noInternet.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/bloc/notification_bloc.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/consistency_notifications.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/custome_contest_invite.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/friend_accepted_notification.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/friend_invite_notification.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/post_contest_notification.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/widgets/upcoming_contest_notifications.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/acceptOrRejectCubit/accept_or_reject_friend_reques_cubit.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(GetNotificationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showErrorMessage(String? message) {
      final snackBar = SnackBar(
        content: Text(
          message ?? 'Unknow error happened, please try again.',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(255, 172, 68, 61),
      );
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
        ),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AcceptOrRejectFriendRequesCubit,
              AcceptOrRejectFriendRequesState>(
            listener: (context, state) {
              if (state is FriendRequestAcceptedState) {
                context.read<NotificationBloc>().add(GetNotificationsEvent());
              } else if (state is AcceptOrRejectFriendRequesFailedState) {
                showErrorMessage(
                    'Could not perform the action. Please try again!');
              }
            },
          )
        ],
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationsLoadingState) {
              return _notificationsShimmer();
            } else if (state is NotificationsLoadedState) {
              if (state.notifications.isEmpty) {
                return const EmptyListWidget(
                  message: 'You have no notifications',
                  icon: 'assets/images/emptypage.svg',
                );
              }
              return Padding(
                  padding: EdgeInsets.only(top: 0.h, right: 6.w, left: 6.w),
                  child: ListView.separated(
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      print("here");
                      final type = state.notifications[index].type;
                      if (type == NotificationTypes.friendRequest) {
                        return FriendInviteNotification(
                          senderAvatar:
                              state.notifications[index].sender!.avatar!,
                          senderName:
                              '${state.notifications[index].sender!.name} ${state.notifications[index].sender!.lastName}',
                          date: state.notifications[index].date,
                          requestId: state.notifications[index].requestId!,
                        );
                      } else if (type == NotificationTypes.registeredContest) {
                        // registered contest
                        return UpcomingContestNotificationWidget(
                          forRegisteredContest: true,
                          date: state.notifications[index].date,
                          contestDescription:
                              state.notifications[index].contest!.description,
                          contestId: state.notifications[index].contest!.id,
                        );
                      } else if (type ==
                          NotificationTypes.accepterdFriendRequest) {
                        return FriendAcceptedNotification(
                          date: state.notifications[index].date,
                          reciverAvatar:
                              state.notifications[index].receiver!.avatar!,
                          senderAvatar:
                              state.notifications[index].sender!.avatar!,
                          senderName: state.notifications[index].receiver!.id ==
                                  state.notifications[index].userId
                              ? state.notifications[index].sender!.name
                              : state.notifications[index].receiver!.name,
                          receiverId: state.notifications[index].receiver!.id ==
                                  state.notifications[index].userId
                              ? state.notifications[index].sender!.id
                              : state.notifications[index].receiver!.id,
                        );
                        //} else if (type == NotificationTypes.contestProgress) {
                        //   // contest progress
                        // }
                        //else if (type == NotificationTypes.contestWinner) {
                        //   // contest winner
                      } else if (type == NotificationTypes.invitedContest) {
                        // invited contest
                        // return const PostContestNotification();
                        // return const ConsistencyNotifications();
                        return UpcomingContestNotificationWidget(
                          forRegisteredContest: false,
                          date: state.notifications[index].date,
                          contestDescription:
                              state.notifications[index].contest!.description,
                          contestId: state.notifications[index].contest!.id,
                        );
                      } else if (type ==
                          NotificationTypes.weeklyProgressReport) {
                        // General notification for weekly report
                        return ConsistencyNotifications(
                          date: state.notifications[index].notification.date,
                          weeklyReportText:
                              state.notifications[index].notification.content,
                        );
                      } else if (type ==
                              NotificationTypes.customeContestInvite ||
                          type == NotificationTypes.customeContestRegistered) {
                        // invited contest
                        // return const PostContestNotification();
                        // return const ConsistencyNotifications();
                        var forRegisteredContest = false;
                        if (type ==
                            NotificationTypes.customeContestRegistered) {
                          forRegisteredContest = true;
                        }
                        return CustomeContestInvitationWidget(
                          forRegisteredContest: forRegisteredContest,
                          invitedBy: state.notifications[index].invitedBy,
                          invitedById: state.notifications[index].invitedById,
                          date: state.notifications[index].date,
                          contestDescription:
                              state.notifications[index].contest!.description,
                          contestId: state.notifications[index].contest!.id,
                        );
                      }
                      //else if (type == NotificationTypes.studyReminder) {
                      //   // study reminder
                      // }
                      return Container();
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.5.h,
                      ),
                      child: const Divider(
                        color: Color.fromARGB(255, 227, 227, 227),
                      ),
                    ),
                  ));
            } else if (state is NotificationsFailedtate) {
              return NoInternet(
                reloadCallback: () {
                  context.read<NotificationBloc>().add(GetNotificationsEvent());
                },
              );
              // return const Center(child: Text('error'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Shimmer _notificationsShimmer() {
    return Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        baseColor: const Color.fromARGB(255, 236, 235, 235),
        highlightColor: const Color(0xffF9F8F8),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 2.h,
                            width: 55.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                          ),
                          SizedBox(height: .5.h),
                          Container(
                            height: 2.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        height: 1.5.h,
                        width: 10.w,
                        decoration: const BoxDecoration(color: Colors.white),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 3.h,
                  ),
              itemCount: 10),
        ));
  }
}
