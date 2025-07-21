import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/core/widgets/animated_dragable_widget.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../core/widgets/three_bounce_spinkit.dart';
import '../../../friends/domain/entities/friend_entitiy.dart';
import '../../../friends/presentation/bloc/allFriendsBloc/friends_bloc.dart';

class CustomContestInviteFriendsPage extends StatefulWidget {
  const CustomContestInviteFriendsPage({
    super.key,
    required this.customContestId,
  });

  final String customContestId;

  @override
  State<CustomContestInviteFriendsPage> createState() => _CustomContestInviteFriendsPageState();
}

class _CustomContestInviteFriendsPageState extends State<CustomContestInviteFriendsPage> {
  late TextEditingController _searchController;
  List<Friend> friends = [];
  List<Friend> unInvitedFriends = [];
  Set<String> friendsSet = <String>{};
  final _scrollController = ScrollController();


  @override
  void initState(){
    super.initState();
    _searchController = TextEditingController();
    // context.read<FriendsBloc>().add(const GetFriendsEvent());
    context.read<FetchFriendsBloc>().add(
        ReFetchPaginatedFriendsEvent(customContestId: widget.customContestId),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<FetchFriendsBloc>().add(FetchPaginatedFriendsEvent(customContestId: widget.customContestId));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final fetchFriendsBloc = BlocProvider.of<FetchFriendsBloc>(context);
    return PopScope(
      onPopInvoked: (_) {
        context.read<FetchRegisteredFriendsForCustomContestBloc>().add(FetchRegisteredFriendsForCustomContestEvent(customContestId: widget.customContestId));
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {context.pop();}, icon: const Icon(Icons.arrow_back),),
          title: Text('Invite Friends', style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),),
          actions: [
            InkWell(
              onTap: friendsSet.isEmpty
                  ? null
                  : () {
                    final friendsList = friendsSet.toList();
                    context.read<SendInvitesForCustomContestBloc>().add(
                      SendInvitesForCustomContestEvent(
                        contestId: widget.customContestId,
                        friendsList: friendsList,
                      ),
                    );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: friendsSet.isEmpty ? Colors.grey.withOpacity(0.7) : const Color(0xFF18786A),
                ),
                child: BlocConsumer<SendInvitesForCustomContestBloc, SendInvitesForCustomContestState>(
                  listener: (context, state) {
                    if(state is SendInvitesForCustomContestLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Invitation sent successfully',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: const Color(0xFF18786a),
                            behavior: SnackBarBehavior.floating,
                          ),
                      );
                      CustomContestDetailPageRoute(customContestId: widget.customContestId).go(context);
                    } else if (state is SendInvitesForCustomContestFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'The invitation failed to send. Please check your internet and try again later',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if(state is SendInvitesForCustomContestLoading) {
                      return const SizedBox(
                        height: 20,
                        child:  ThreeBounceSpinkit(),
                      );
                    }
                    return Text(
                      'Invite${friendsSet.isNotEmpty ? '(${friendsSet.length})' : ''}',
                      style: GoogleFonts.poppins(
                        color: friendsSet.isEmpty ? Colors.black.withOpacity(0.6) : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _searchController,
                  onChanged: (searchTerm) {
                   context.read<FetchFriendsBloc>().add(
                     FetchSearchedFriendsFromPaginatedFriendsEvent(searchTerm: searchTerm),
                   );
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search name..',
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suggested Friends',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if(friends.isNotEmpty)
                      InkWell(
                        onTap: (){
                          setState(() {
                            if(unInvitedFriends.length == friendsSet.length) {
                              friendsSet = <String>{};
                            } else {
                              for(var friend in unInvitedFriends) {
                                if(!friendsSet.contains(friend.id)) {
                                  friendsSet.add(friend.id);
                                }
                              }
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          child: Text(
                            friendsSet.length == unInvitedFriends.length
                                ? 'Unselect all'
                                : 'Select all',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF18786A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                BlocBuilder<FetchFriendsBloc, FetchFriendsState>(
                  builder: (context, state) {
                    if(state is FetchFriendsState && state.status == FetchFriendsEnum.initial) {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => _friendsCardShimmer(),
                        separatorBuilder: (context, index) => SizedBox(height: 2.h),
                        itemCount: 3,
                      );
                    } else if (state is FetchFriendsState && state.status == FetchFriendsEnum.failure) {
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
                                  .read<FetchFriendsBloc>()
                                  .add(
                                  FetchPaginatedFriendsEvent(customContestId: widget.customContestId));
                            },
                          ),
                        ),
                      );
                    } else if (state is FetchFriendsState && state.status == FetchFriendsEnum.success) {
                      friends = state.friends;
                      unInvitedFriends = state.friends.where((friend) => friend.contestStatus == 'Not-invited').toList();
                    }

                    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      if(friends.isEmpty)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            margin: EdgeInsets.only(top: 8.h),
                            child: Column(
                              children: [
                                Image.asset('assets/images/friends_not_found.png'),
                                const SizedBox(height: 12),
                                Text(
                                  'You don\'t have friends',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                InkWell(
                                  onTap: () {
                                    CustomContestAddFriendsPageRoute(customContestId: widget.customContestId).go(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF16786A),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Add Friends',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      if(friends.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final isSelected = friendsSet.contains(friends[index].id);
                              return InkWell(
                                onTap: friends[index].contestStatus != 'Not-invited' ? null : () {
                                  setState(() {
                                    if (friendsSet
                                        .contains(friends[index].id)) {
                                      friendsSet.remove(friends[index].id);
                                    } else {
                                      friendsSet.add(friends[index].id);
                                    }
                                  });
                                 },
                                child: FriendCardWidget(friend: friends[index], isSelected: isSelected),
                                );
                              },
                            itemCount: friends.length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
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
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
