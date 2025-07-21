import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/core/constants/dummydata.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/withdrawRequestCubit/withdraw_friend_request_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/getSentRequestsBloc/get_sent_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/profiles_listing_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SentFriendRequestsTab extends StatelessWidget {
  const SentFriendRequestsTab({
    super.key,
    required this.user,
  });
  final FriendEntity user;
  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawFriendRequestCubit, WithdrawFriendRequestState>(
      listener: (context, withdrawState) {
        if (withdrawState is WithdrawFriendRequestSuccess &&
            withdrawState.requestId == user.requestId) {
          context.read<GetSentRequestsBloc>().add(const GetSentRequestsEvent());
        }
      },
      child: ProfilesListingCard(
        data: user,
        leftWidget: InkWell(
          onTap: () {
            context.read<WithdrawFriendRequestCubit>().withdrawRequest(
                requestId: user.requestId!, isForUnfriend: false);
          },
          child: Container(
            alignment: Alignment.center,
            // padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            height: 4.5.h,
            width: 25.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffD9D9D9),
            ),
            child: BlocBuilder<WithdrawFriendRequestCubit,
                WithdrawFriendRequestState>(
              builder: (context, state) {
                if (state is WithdrawFriendRequestLoading &&
                    state.requestId == user.requestId) {
                  return const CustomProgressIndicator(
                    size: 16,
                  );
                }
                return Text(
                  AppLocalizations.of(context)!.withdraw,
                  style: const TextStyle(
                    color: Color(0xff2B2B2B),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
