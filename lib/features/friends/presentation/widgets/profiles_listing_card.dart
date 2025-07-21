import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';

class ProfilesListingCard extends StatelessWidget {
  const ProfilesListingCard({
    super.key,
    required this.leftWidget,
    required this.data,
  });
  final Widget leftWidget;
  final FriendEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff18786a).withOpacity(.1),
              image: DecorationImage(
                // image: NetworkImage(data['image']!),

                image: CachedNetworkImageProvider(
                  data.avatar ?? defaultProfileAvatar,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.firstName} ${data.lastName}',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: .5.h),
                Text(
                  '${data.point.ceil()} points',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          leftWidget,
        ],
      ),
    );
  }
}

Shimmer profileListingCardShimmer(
    {required Widget leftWidget, Widget? bottomWidget}) {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ltr,
    baseColor: const Color.fromARGB(255, 236, 235, 235),
    highlightColor: const Color(0xffF9F8F8),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 2.5.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: .5.h),
                  Container(
                    height: 1.5.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            leftWidget,
          ],
        ),
        if (bottomWidget != null) SizedBox(height: 1.h),
        if (bottomWidget != null) bottomWidget,
      ],
    ),
  );
}
