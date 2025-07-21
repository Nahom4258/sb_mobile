import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../friends/domain/entities/friend_entitiy.dart';

class CustomContestDetailPage extends StatefulWidget {
  const CustomContestDetailPage({
    super.key,
    required this.customContestId,
  });

  final String customContestId;

  @override
  State<CustomContestDetailPage> createState() =>
      _CustomContestDetailPageState();
}

class _CustomContestDetailPageState extends State<CustomContestDetailPage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  Set submittedCategories = {};
  List<FriendEntity> friends = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 2);
    context.read<FetchCustomContestDetailBloc>().add(
          FetchCustomContestDetailEvent(
              customContestId: widget.customContestId),
        );
    context.read<FetchRegisteredFriendsForCustomContestBloc>().add(
        FetchRegisteredFriendsForCustomContestEvent(
            customContestId: widget.customContestId,
        ),
    );
    context.read<FetchCustomContestRankingBloc>().add(
        FetchCustomContestRankingEvent(
            customContestId: widget.customContestId,
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _tabController.dispose();
  }

  void updateSubmittedCategories(String categoryId) {
    setState(() {
      submittedCategories.add(categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteCustomContestByIdBloc, DeleteCustomContestByIdState>(
      listener: (context, state) {
        if(state is DeleteCustomContestByIdLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                    'Contest deleted successfully',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
          );
          context.pop();
        } else if(state is DeleteCustomContestByIdFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Contest deletion failed',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: PopScope(
        onPopInvoked: (_) {
          context.read<FetchUpcomingCustomContestBloc>().add(const FetchUpcomingCustomContestEvent());
          context.read<FetchLiveContestBloc>().add(FetchingLiveContestEvent());
          context.read<FetchCustomContestInvitationsBloc>().add(const FetchCustomContestInvitationsEvent());
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   leading: IconButton(
            //     onPressed: () {
            //       context.read<FetchUpcomingCustomContestBloc>().add(
            //         const FetchUpcomingCustomContestEvent(),
            //       );
            //       context.read<FetchPreviousCustomContestBloc>().add(
            //         const FetchPreviousCustomContestEvent(),
            //       );
            //
            //       context.pop();
            //     },
            //     icon: const Icon(Icons.arrow_back),
            //   ),
            // ),
            body: BlocConsumer<FetchCustomContestDetailBloc,
                    FetchCustomContestDetailState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is FetchCustomContestDetailFailed) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: EmptyListWidget(
                          icon: 'assets/images/emptypage.svg',
                          showImage: false,
                          message: AppLocalizations.of(context)!
                              .check_your_internet_connection_and_try_again,
                          reloadCallBack: () {
                            context.read<FetchCustomContestDetailBloc>().add(
                                  FetchCustomContestDetailEvent(
                                    customContestId: widget.customContestId,
                                  ),
                                );
                            // context
                            //     .read<ContestRankingBloc>()
                            //     .add(const ContestRankingEvent());
                          },
                        ),
                      ),
                    );
                  } else if (state is FetchCustomContestDetailLoading) {
                    return const LinearProgressIndicator();
                  } else if (state is FetchCustomContestDetailLoaded) {
                    final customContestDetail = state.customContestDetail;
                    final contestDuration = customContestDetail.endsAt.difference(customContestDetail.startsAt);

                    return NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (context, value) => [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          pinned: false,
                          snap: true,
                          floating: true,
                          elevation: 0,
                          scrolledUnderElevation: 0,
                          title: Text(
                            customContestDetail.title,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          leading: IconButton(
                            onPressed: () {
                              context.read<FetchUpcomingCustomContestBloc>().add(
                                    const FetchUpcomingCustomContestEvent(),
                                  );
                              context.read<FetchPreviousCustomContestBloc>().add(
                                    const FetchPreviousCustomContestEvent(),
                                  );

                              context.pop();
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          // expandedHeight: 120,
                          // flexibleSpace: FlexibleSpaceBar(
                          //   title: Text(
                          //     customContestDetail.title,
                          //     style: GoogleFonts.poppins(
                          //       color: Colors.black,
                          //       fontSize: 17,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          // ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.calendar_month, color: Color(0xFF3E3E3E), size: 20),
                                    const SizedBox(width: 6),
                                    Text(DateFormat('MMM dd, yyyy').format(customContestDetail.startsAt), style: GoogleFonts.poppins(color: const Color(0xFF3E3E3E)),),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  customContestDetail.description,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, color: Color(0xFF3E3E3E)),
                                    const SizedBox(width: 6),
                                    Text(formatDuration(contestDuration), style: GoogleFonts.poppins(color: const Color(0xFF3E3E3E)),),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.person, color: Color(0xFF3E3E3E)),
                                    const SizedBox(width: 6),
                                    BlocBuilder<FetchRegisteredFriendsForCustomContestBloc, FetchRegisteredFriendsForCustomContestState>(
                                      builder: (context, state) {
                                        if(state is FetchRegisteredFriendsForCustomContestLoading) {
                                          return _textShimmer();
                                        } else if (state is FetchRegisteredFriendsForCustomContestLoaded) {
                                          return Text('${state.friends.length} registered', style: GoogleFonts.poppins(color: const Color(0xFF3E3E3E)),);
                                        } else if (state is FetchRegisteredFriendsForCustomContestFailed) {
                                          return Text('Error loading', style: GoogleFonts.poppins(color: const Color(0xFF3E3E3E)),);
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.help_outline, color: Color(0xFF3E3E3E)),
                                    const SizedBox(width: 6),
                                    Text('${customContestDetail.customContestCategories.length} subject${customContestDetail.customContestCategories.length > 1 ? 's' : ''}', style: GoogleFonts.poppins(color: const Color(0xFF3E3E3E)),),
                                  ],
                                ),
                                if (customContestDetail.isOwner)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (customContestDetail.isUpcoming)
                                          InkWell(
                                            onTap: () {
                                              CustomContestUpdatePageRoute(
                                                      $extra: customContestDetail,
                                                      customContestId:
                                                          customContestDetail
                                                              .customContestId)
                                                  .go(context);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 12),
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 12),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF18786A),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.edit,
                                                      color: Colors.white, size: 20),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    AppLocalizations.of(context)!.edit_contest,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        InkWell(
                                          onTap: () {
                                            context.read<DeleteCustomContestByIdBloc>().add(DeleteCustomContestByIdEvent(customContestId: widget.customContestId));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE56441),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.delete,
                                                    color: Colors.white, size: 20),
                                                const SizedBox(width: 6),
                                                Text(
                                                  AppLocalizations.of(context)!.delete_contest,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 1.h),
                              ],
                            ),
                          ),
                        ),
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          pinned: true,
                          snap: false,
                          elevation: 0,
                          scrolledUnderElevation: 0,
                          backgroundColor: Colors.white,
                          title: TabBar(
                            controller: _tabController,
                            indicatorColor: const Color(0xff18786a),
                            labelColor: Colors.black,
                            unselectedLabelColor: const Color(0xFF727171),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Tab(
                                child: Text(
                                  AppLocalizations.of(context)!.questions,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  state.customContestDetail.hasEnded
                                  ? AppLocalizations.of(context)!.ranking
                                  : AppLocalizations.of(context)!.registered_friends,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      body: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ListView.separated(
                                        itemCount: customContestDetail
                                            .customContestCategories.length,
                                        separatorBuilder: (context, index) =>
                                            Container(
                                          height: 1,
                                          color: const Color(0xFFE4E4E4),
                                        ),
                                        itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            if (customContestDetail.hasEnded ||
                                                (!customContestDetail
                                                        .customContestCategories[
                                                            index]
                                                        .isSubmitted &&
                                                    !state.customContestDetail
                                                        .hasEnded)) {
                                              CustomContestQuestionByCategoryPageRoute(
                                                customContestId:
                                                    widget.customContestId,
                                                $extra:
                                                    ContestQuestionByCategoryPageParams(
                                                  contestId: widget.customContestId,
                                                  categoryId: customContestDetail
                                                      .customContestCategories[index]
                                                      .id,
                                                  customContestCategories:
                                                      customContestDetail
                                                          .customContestCategories,
                                                  updateSubmittedCategories:
                                                      updateSubmittedCategories,
                                                  isCustomContest: true,
                                                  timeLeft: Duration(
                                                      seconds: customContestDetail
                                                          .timeLeft
                                                          .toInt()),
                                                  hasEnded:
                                                      customContestDetail.hasEnded,
                                                ),
                                              ).go(context);
                                            } else {
                                              showPopupOnCompletingContest(
                                                context: context,
                                                onCompleted: () {},
                                                title: customContestDetail.hasEnded
                                                    ? AppLocalizations.of(context)!
                                                        .contest_has_ended
                                                    : AppLocalizations.of(context)!
                                                        .you_have_submitted_for_this_category_successfully,
                                                isSubmitted:
                                                    !customContestDetail.hasEnded,
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(
                                                    index == 0 ? 4 : 0),
                                                bottom: Radius.circular(index ==
                                                        customContestDetail
                                                                .customContestCategories
                                                                .length -
                                                            1
                                                    ? 4
                                                    : 0),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                            maxWidth:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                          ),
                                                          child: Text(
                                                            customContestDetail
                                                                .customContestCategories[
                                                                    index]
                                                                .subject,
                                                            style:
                                                                GoogleFonts.poppins(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 6),
                                                        if ((customContestDetail
                                                                    .isOwner &&
                                                                customContestDetail
                                                                    .hasEnded) ||
                                                            (customContestDetail
                                                                    .hasRegistered &&
                                                                customContestDetail
                                                                    .hasEnded))
                                                          Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical: 6,
                                                                horizontal: 4),
                                                            decoration: BoxDecoration(
                                                              color: const Color(
                                                                      0xFF18786A)
                                                                  .withOpacity(0.11),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(4),
                                                            ),
                                                            child: Text(
                                                              '${customContestDetail.customContestCategories[index].userScore}${AppLocalizations.of(context)!.pts}',
                                                              style:
                                                                  GoogleFonts.poppins(
                                                                color: const Color(
                                                                  0xFF18786A,
                                                                ),
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        maxWidth:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.5,
                                                      ),
                                                      child: Text(
                                                        '${customContestDetail.customContestCategories[index].numberOfQuestions.toString()} ${AppLocalizations.of(context)!.questions}',
                                                        style: GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    color: (!customContestDetail
                                                                .customContestCategories[
                                                                    index]
                                                                .isSubmitted &&
                                                            state.customContestDetail
                                                                .hasEnded)
                                                        ? const Color(0xFFFF6652)
                                                        : const Color(0xFF1A7A6C),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    customContestDetail
                                                            .customContestCategories[
                                                                index]
                                                            .isSubmitted
                                                        ? Icons.check
                                                        : (!customContestDetail
                                                                    .customContestCategories[
                                                                        index]
                                                                    .isSubmitted &&
                                                                state
                                                                    .customContestDetail
                                                                    .hasEnded)
                                                            ? Icons.close
                                                            : Icons
                                                                .keyboard_arrow_right_outlined,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // if ((customContestDetail.isOwner &&
                                      //         !(customContestDetail.isLive ||
                                      //             customContestDetail.hasEnded)) ||
                                      //     (!customContestDetail.isOwner &&
                                      //         (!(customContestDetail.hasRegistered &&
                                      //             customContestDetail.isLive) || !customContestDetail.hasEnded)))
                                      if(!(customContestDetail.isOwner && (customContestDetail.isLive || customContestDetail.hasEnded)))
                                        BackdropFilter(
                                          filter: ui.ImageFilter.blur(
                                            sigmaX: 8.0,
                                            sigmaY: 8.0,
                                          ),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height:
                                                MediaQuery.of(context).size.height,
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              // Colors.grey.shade200.withOpacity(0.9),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.lock,
                                                color: Color(0XFF1A7A6C),
                                                size: 48,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  if(state.customContestDetail.hasEnded)
                                    CustomContestRankingSection(
                                      customContestId: widget.customContestId,
                                    ),
                                  if(!state.customContestDetail.hasEnded)SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        BlocBuilder<FetchRegisteredFriendsForCustomContestBloc, FetchRegisteredFriendsForCustomContestState>(
                                          builder: (context, state) {
                                            if(state is FetchRegisteredFriendsForCustomContestLoading) {
                                              return ListView.separated(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return _friendsCardShimmer();
                                                },
                                                separatorBuilder: (context, index) =>
                                                    SizedBox(height: 2.h),
                                                itemCount: 3,
                                              );
                                            } else if (state is FetchRegisteredFriendsForCustomContestFailed) {
                                              return Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(bottom: 16),
                                                  child: EmptyListWidget(
                                                    icon: 'assets/images/emptypage.svg',
                                                    showImage: false,
                                                    message: AppLocalizations.of(context)!
                                                        .check_your_internet_connection_and_try_again,
                                                    reloadCallBack: () {
                                                      context
                                                          .read<FetchRegisteredFriendsForCustomContestBloc>()
                                                          .add(
                                                          FetchRegisteredFriendsForCustomContestEvent(customContestId: widget.customContestId));
                                                    },
                                                  ),
                                                ),
                                              );
                                            } else if (state is FetchRegisteredFriendsForCustomContestLoaded) {
                                              friends = state.friends;
                                            }
                                            if(friends.isEmpty) {
                                              return FriendsNotFoundWidget(
                                                customContestId: widget.customContestId,
                                              );
                                            }

                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.people,
                                                          color: Color(0xFF4A4A4A),
                                                        ),
                                                        const SizedBox(width: 6),
                                                        Text(
                                                          '${friends.length} ${AppLocalizations.of(context)!.friends}',
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        CustomContestInviteFriendsPageRoute(
                                                            customContestId:
                                                            widget.customContestId)
                                                            .go(context);
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            vertical: 6, horizontal: 12),
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xFF18786A),
                                                          borderRadius:
                                                          BorderRadius.circular(12),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.add,
                                                              color: Colors.white,
                                                            ),
                                                            const SizedBox(width: 6),
                                                            Text(
                                                              AppLocalizations.of(context)!.invite_friends,
                                                              style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 24),
                                                ListView.separated(
                                                  physics:
                                                  const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: friends.length,
                                                  separatorBuilder: (context, index) =>
                                                  const SizedBox(height: 16),
                                                  itemBuilder: (context, index) =>
                                                      FriendEntityCardWidget(friendEntity: friends[index]),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                  // ListView.builder(
                                  //   physics: const NeverScrollableScrollPhysics(),
                                  //   shrinkWrap: true,
                                  //   itemCount: customContestDetail.customcustomContestDetail.customContestCategories.length,
                                  //   itemBuilder: (context, index) =>
                                  //       QuestionsCard(
                                  //         customContestCategory: customContestDetail.customcustomContestDetail.customContestCategories[index],
                                  //         isOwner: customContestDetail.isOwner,
                                  //         isLastItem: index == customContestDetail.customcustomContestDetail.customContestCategories.length - 1,
                                  //         displayEditButton: false,
                                  //       ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                },
            ),
          ),
      ),
    );
  }

  Shimmer _friendsCardShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35.w,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 25.w,
                  height: 14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Shimmer _textShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
