import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:skill_bridge_mobile/core/constants/app_images.dart';

import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/sendFriendRequestBloc/send_friend_request_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/withdrawRequestCubit/withdraw_friend_request_cubit.dart';

import 'package:skill_bridge_mobile/features/profile/presentation/bloc/logout/logout_bloc.dart';

import '../../../../core/utils/snack_bar.dart';

class LeaderbordDetailHeader extends StatelessWidget {
  final int? grade;
  final String firstName;
  final String lastName;
  final String avatar;
  final String userId;
  final String friendShipStatus;

  const LeaderbordDetailHeader({
    super.key,
    this.grade,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.userId,
    required this.friendShipStatus,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogOutFailedState &&
            state.failure is RequestOverloadFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar(state.failure.errorMessage));
        }
        if (state is LogedOutState) {
          LoginPageRoute().go(context);
        }
      },
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(avatar),
                      fit: BoxFit.cover,
                    )),
              ),
              if (grade != null)
                Positioned(
                  bottom: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/profileBadge.png',
                        height: 5.h,
                        width: 110,
                      ),
                      Positioned(
                        top: .75.h,
                        child: Text(
                          'Grade ${grade.toString()}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$firstName $lastName',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: .5.h),
                //
                InkWell(
                  onTap: () {
                    if (friendShipStatus == 'not friends') {
                      context
                          .read<SendFriendRequestBloc>()
                          .add(SendFriendRequestEvent(userId: userId));
                    } else if (friendShipStatus == 'pending') {
                      context
                          .read<WithdrawFriendRequestCubit>()
                          .withdrawRequest(
                              requestId: userId, isForUnfriend: false);
                    } else if (friendShipStatus == 'accepted') {
                      context
                          .read<WithdrawFriendRequestCubit>()
                          .withdrawRequest(
                              requestId: userId, isForUnfriend: true);
                    }
                  },
                  child: Container(
                    height: 4.h,
                    width: 35.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: friendShipStatus == 'not friends'
                          ? const Color(0xff18786a)
                          : Colors.grey,
                    ),
                    child: BlocBuilder<WithdrawFriendRequestCubit,
                        WithdrawFriendRequestState>(
                      builder: (context, withdrawState) {
                        return BlocBuilder<SendFriendRequestBloc,
                            SendFriendRequestState>(
                          builder: (context, sendState) {
                            if (sendState is SendingFriendRequestState ||
                                withdrawState is WithdrawFriendRequestLoading) {
                              return const CustomProgressIndicator(
                                color: Colors.white,
                                size: 14,
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (friendShipStatus == 'not friends')
                                  const Icon(
                                    Icons.person_add_alt_1,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                // if (friendShipStatus == 'accepted' ||
                                //     friendShipStatus == 'pending')
                                //   const Icon(
                                //     Icons.,
                                //     size: 18,
                                //     color: Colors.white,
                                //   ),
                                SizedBox(width: 1.w),
                                if (friendShipStatus == 'not friends')
                                  const Text(
                                    'Add friend',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                if (friendShipStatus == 'pending')
                                  const Text(
                                    'Withdraw',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                if (friendShipStatus == 'accepted')
                                  const Text(
                                    'Unfriend',
                                    style: TextStyle(color: Colors.white),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
