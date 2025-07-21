import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/bloc/localeBloc/locale_bloc.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/core/routes/go_routes.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DynamicHomepageProfileHeader extends StatelessWidget {
  DynamicHomepageProfileHeader({super.key});
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserBloc, GetUserState>(
      builder: (context, state) {
        if (state is GetUserCredentialState &&
            state.status == GetUserStatus.loaded) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  // width: 65.w,
                  child: InkWell(
                    onTap: () {
                      UpdatedProfilePageRoute().go(context);
                    },
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff18786a).withOpacity(.3),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  state.userCredential!.profileAvatar != null
                                      ? state.userCredential!.profileAvatar!
                                      : defaultProfileAvatar),
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        SizedBox(
                          width: 55.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.greeting(state.userCredential!.firstName)} 👋',
                                maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .pick_up_from_where_you_left_off,
                                maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Colors.black.withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
                  if (homeState is GetHomeState &&
                      homeState.status == HomeStatus.loaded) {
                    count = homeState.totalUnseenNotifications!;
                    return IconButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(const GetHomeEvent(refresh: true));
                        NotificationsPageRoute().go(context);

                      },
                      icon: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1, vertical: 3),
                            child: Icon(
                              Icons.notifications,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          count > 0
                              ? Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff18786a),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    "$count",
                                    style: const TextStyle(
                                        fontSize: 9, color: Colors.white),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  } else if (homeState is GetHomeState &&
                      homeState.status == HomeStatus.loading) {
                    return _notificationShimmer();
                  }
                  count = 0;
                  return const SizedBox.shrink();
                }),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Shimmer _maxStreakShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image(
            image: AssetImage('assets/images/fireRed.png'),
            height: 30,
            width: 30,
          ),
          Text(
            '0',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xffF53A04),
            ),
          ),
        ],
      ),
    );
  }

  Shimmer _notificationShimmer() {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color(0xffF9F8F8),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
            child: Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xff18786a),
              shape: BoxShape.circle,
            ),
            child: const Text(
              '',
              style: TextStyle(fontSize: 9, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
