import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/searchFriendsBloc/search_friends_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/sendFriendRequestBloc/send_friend_request_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/profiles_listing_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage> {
  final _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;

  @override
  void initState() {
    context
        .read<SearchFriendsBloc>()
        .add(const SearchFriendsEvent(searchKey: '', nextPage: false));
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
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

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context
          .read<SearchFriendsBloc>()
          .add(const SearchFriendsEvent(searchKey: '', nextPage: true));
    }
  }

  void _searchFriends(String input) {
    // Cancel any existing debounce timer
    _debounceTimer?.cancel();
    // Start a new debounce timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // _makeSearchAPICall;

      context
          .read<SearchFriendsBloc>()
          .add(SearchFriendsEvent(searchKey: input, nextPage: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 8.h,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: Text(
          AppLocalizations.of(context)!.add_new_friends,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocListener<SendFriendRequestBloc, SendFriendRequestState>(
        listener: (context, state) {
          if (state is FriendRequestSentState) {
            context.read<SearchFriendsBloc>().add(
                  const SearchFriendsEvent(searchKey: '', nextPage: false),
                );
            showSucessOrErrorMessage(
                'You have sent friend invite successfully!', true);
          }
          if (state is SendFriendRequestFailedState) {
            showSucessOrErrorMessage(
                'Oops! the request could not be sent', true);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                onChanged: _searchFriends,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                cursorHeight: 2.5.h,
              ),
              SizedBox(height: 1.5.h),
              const Divider(),
              SizedBox(height: 2.h),
              Text(
                AppLocalizations.of(context)!.frend_suggestions,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              BlocBuilder<SearchFriendsBloc, SearchFriendsState>(
                builder: (context, state) {
                  if (state is SearchFriendsLoadingState) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            profileListingCardShimmer(
                          leftWidget: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                        itemCount: 8,
                      ),
                    );
                  } else if (state is SearchFriendsFailedState) {
                    return const Center(
                        child: Text('Error loading users. Please try again'));
                  } else if (state is SearchFriendsLoadedState) {
                    final users = state.users.friends;
                    return Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        itemBuilder: (context, index) => InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            FriendsDetailPageRoute(userId: users[index].id)
                                .go(context);
                          },
                          child: ProfilesListingCard(
                            data: users[index],
                            leftWidget: InkWell(
                              onTap: () {
                                if (users[index].requestStatus != 'pending' ||
                                    users[index].requestStatus != 'accepted') {
                                  // skip if bending
                                  context.read<SendFriendRequestBloc>().add(
                                        SendFriendRequestEvent(
                                            userId: users[index].id),
                                      );
                                }
                              },
                              child: BlocBuilder<SendFriendRequestBloc,
                                  SendFriendRequestState>(
                                builder: (context, requestState) {
                                  if (users[index].requestStatus ==
                                      'accepted') {
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.people,
                                        color: Colors.black,
                                      ),
                                    );
                                  }
                                  return Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff18786a),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: requestState
                                                is SendingFriendRequestState &&
                                            requestState.userId ==
                                                users[index].id
                                        ? const CustomProgressIndicator(
                                            color: Colors.white,
                                            size: 14,
                                          )

                                        // requestState is FriendRequestSentState &&
                                        //             requestState.reqeustedUsers
                                        //                 .contains(
                                        //                     users[index].id) ||
                                        : users[index].requestStatus ==
                                                'pending'
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.person_add_alt_1_rounded,
                                                color: Colors.white,
                                              ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                        itemCount: users.length,
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
