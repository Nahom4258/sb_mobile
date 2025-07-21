import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/core/constants/dummydata.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/allFriendsBloc/friends_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/profiles_listing_card.dart';

class FriendsTab extends StatefulWidget {
  const FriendsTab({
    super.key,
  });

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  @override
  void initState() {
    context.read<FriendsBloc>().add(const GetFriendsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        if (state is FriendsLoadingState) {
          return ListView.separated(
            itemBuilder: (context, index) => profileListingCardShimmer(
              leftWidget: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            itemCount: 8,
            physics: const AlwaysScrollableScrollPhysics(),
          );
        } else if (state is FriendsLoadingFailedState) {
          return const Center(child: Text('Error loading friends'));
        } else if (state is FriendsLoadedState) {
          if (state.friends.isEmpty) {
            return const EmptyListWidget(
              icon: 'assets/images/emptypage.svg',
                message:
                    'You have no friends yet. Please add them using the add button at the top right corner.');
          }

          return ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                FriendsDetailPageRoute(userId: state.friends[index].id)
                    .go(context);
              },
              child: ProfilesListingCard(
                data: state.friends[index],
                leftWidget: const Icon(
                  Icons.keyboard_arrow_right,
                  size: 25,
                ),
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            itemCount: state.friends.length,
            physics: const AlwaysScrollableScrollPhysics(),
          );
        }
        return Container();
      },
    );
  }
}
