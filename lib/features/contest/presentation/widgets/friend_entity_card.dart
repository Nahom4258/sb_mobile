import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../features.dart';
import '../../../friends/domain/entities/friend_entitiy.dart';

class FriendEntityCardWidget extends StatelessWidget {
  const FriendEntityCardWidget({
    super.key,
    required this.friendEntity,
  });


  final FriendEntity friendEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
                image: DecorationImage(
                    image: friendEntity.avatar == null
                        ? Image.network(defaultProfileAvatar).image
                        : Image.network(friendEntity.avatar!).image
                )
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${friendEntity.firstName} ${friendEntity.lastName}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${friendEntity.point.toInt()} point${friendEntity.point.toInt() > 1 ? 's' : ''}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
