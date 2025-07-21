import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/core/constants/dummydata.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/acceptOrRejectCubit/accept_or_reject_friend_reques_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/profiles_listing_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReceicedRequestsTab extends StatelessWidget {
  const ReceicedRequestsTab({
    super.key,
    required this.user,
  });
  final FriendEntity user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Column(
        children: [
          ProfilesListingCard(
            data: user,
            leftWidget: const Icon(
              Icons.keyboard_arrow_right,
              size: 25,
            ),
          ),
          SizedBox(height: 1.h),
          BlocBuilder<AcceptOrRejectFriendRequesCubit,
              AcceptOrRejectFriendRequesState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AcceptDeclineWidget(
                    color: const Color(0xff18786a),
                    onClick: () {
                      context
                          .read<AcceptOrRejectFriendRequesCubit>()
                          .acceptFriendRequest(requestId: user.requestId!);
                    },
                    textColor: Colors.white,
                    title: (state is AcceptFriendRequesLoadingState) &&
                            state.requestId == user.requestId
                        ? '...'
                        : AppLocalizations.of(context)!.accept,
                  ),
                  AcceptDeclineWidget(
                    color: const Color(0xffD9D9D9),
                    onClick: () {
                      context
                          .read<AcceptOrRejectFriendRequesCubit>()
                          .rejectFriendRequest(requestId: user.requestId!);
                    },
                    textColor: Colors.black,
                    title: (state is RejectFriendRequesLoadingState) &&
                            state.requestId == user.requestId
                        ? '...'
                        : AppLocalizations.of(context)!.decline,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class AcceptDeclineWidget extends StatelessWidget {
  const AcceptDeclineWidget({
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
        height: 4.3.h,
        width: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7),
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
