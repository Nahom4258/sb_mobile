import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:skill_bridge_mobile/core/widgets/empty_list_widget.dart';

import 'package:skill_bridge_mobile/features/friends/presentation/bloc/acceptOrRejectCubit/accept_or_reject_friend_reques_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/getRecivedRequestsBloc/get_recived_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/getSentRequestsBloc/get_sent_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/profiles_listing_card.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/receiced_requests_tab.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/requests_tab_card.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/sent_friends_requests_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestsTab extends StatefulWidget {
  const RequestsTab({super.key});

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();

    context.read<GetRecivedRequestsBloc>().add(const GetRecivedRequestsEvent());
    context.read<GetSentRequestsBloc>().add(const GetSentRequestsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showSucessOrErrorMessage(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: success
          ? const Color(0xff18786a)
          : const Color.fromARGB(255, 172, 68, 61),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocListener(
      listeners: [
        BlocListener<AcceptOrRejectFriendRequesCubit,
            AcceptOrRejectFriendRequesState>(listener: (context, state) {
          if (state is FriendRequestAcceptedState) {
            showSucessOrErrorMessage('Congrats! You are now friends.', true);
            context
                .read<GetRecivedRequestsBloc>()
                .add(const GetRecivedRequestsEvent());
          }
          if (state is FriendRequestRejectedState) {
            showSucessOrErrorMessage('Friend request rejected.', true);
            context
                .read<GetRecivedRequestsBloc>()
                .add(const GetRecivedRequestsEvent());
          }
          if (state is AcceptOrRejectFriendRequesFailedState) {
            showSucessOrErrorMessage(
                'Something went wrong. Please try again.', false);
          }
        }),
      ],
      child: Column(
        children: [
          SizedBox(height: 2.h),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _tabIndex = 0;
                  });
                  context
                      .read<GetSentRequestsBloc>()
                      .add(const GetSentRequestsEvent());
                },
                child: BlocBuilder<GetSentRequestsBloc, GetSentRequestsState>(
                  builder: (context, state) {
                    return RequestsTabWidget(
                      number: state is GetSentRequestsLoadedState
                          ? (state).friends.length
                          : 0,
                      selected: _tabIndex == 0,
                      title: AppLocalizations.of(context)!.sent,
                    );
                  },
                ),
              ),
              SizedBox(width: 2.w),
              InkWell(
                onTap: () {
                  setState(() {
                    _tabIndex = 1;
                  });
                  context
                      .read<GetRecivedRequestsBloc>()
                      .add(const GetRecivedRequestsEvent());
                },
                child: BlocBuilder<GetRecivedRequestsBloc,
                    GetRecivedRequestsState>(
                  builder: (context, state) {
                    return RequestsTabWidget(
                      number: (state is GetRecivedRequestsLoadedState)
                          ? (state).friends.length
                          : 0,
                      selected: _tabIndex == 1,
                      title: AppLocalizations.of(context)!.received,
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          //sent requests
          if (_tabIndex == 0)
            BlocBuilder<GetSentRequestsBloc, GetSentRequestsState>(
              builder: (context, state) {
                if (state is GetSentRequestsLoadingState) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<GetSentRequestsBloc>()
                            .add(const GetSentRequestsEvent());
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return profileListingCardShimmer(
                            leftWidget: Container(
                              height: 4.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                      ),
                    ),
                  );
                } else if (state is GetSentRequestsFailedState) {
                  return const Center(child: Text('Error loading friends'));
                } else if (state is GetSentRequestsLoadedState) {
                  if (state.friends.isEmpty) {
                    return const EmptyListWidget(
                      icon: 'assets/images/emptypage.svg',
                        message: 'You have no sent requests.');
                  }
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<GetSentRequestsBloc>()
                            .add(const GetSentRequestsEvent());
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.friends.length,
                        itemBuilder: (context, index) {
                          return SentFriendRequestsTab(
                            user: state.friends[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          // Quizzes Tab Content
          if (_tabIndex == 1)
            BlocBuilder<GetRecivedRequestsBloc, GetRecivedRequestsState>(
              builder: (context, state) {
                if (state is GetRecivedRequestsLoadingState) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<GetSentRequestsBloc>()
                            .add(const GetSentRequestsEvent());
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return profileListingCardShimmer(
                            leftWidget: Container(
                              height: 4.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            bottomWidget: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 4.3.h,
                                    width: 40.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  Container(
                                    height: 4.3.h,
                                    width: 40.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  )
                                ]),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                      ),
                    ),
                  );
                } else if (state is GetRecivedRequestsFailedState) {
                  return const Center(child: Text('Error loading friends'));
                } else if (state is GetRecivedRequestsLoadedState) {
                  if (state.friends.isEmpty) {
                    return const EmptyListWidget(
                      icon: 'assets/images/emptypage.svg',
                        message: 'You have no friend requests.');
                  }
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<GetRecivedRequestsBloc>()
                            .add(const GetRecivedRequestsEvent());
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.friends.length,
                        itemBuilder: (context, index) {
                          return ReceicedRequestsTab(
                            user: state.friends[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 1.h),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
        ],
      ),
    ));
  }
}
