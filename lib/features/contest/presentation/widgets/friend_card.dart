import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../features.dart';
import '../../../friends/domain/entities/friend_entitiy.dart';

class FriendCardWidget extends StatelessWidget {
  const FriendCardWidget({
    super.key,
    required this.friend,
    required this.isSelected,
  });


  final Friend friend;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: friend.contestStatus != 'Not-invited' ? Colors.grey.withOpacity(0.09) : isSelected ? const Color(0xFF18786A).withOpacity(0.07) : Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
                          image: friend.avatar == null
                              ? Image.network(defaultProfileAvatar).image
                              : Image.network(friend.avatar!).image
                      )
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${friend.firstName} ${friend.lastName}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${friend.points.toInt()} point${friend.points.toInt() > 1 ? 's' : ''}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF18786A).withOpacity(0.4) : Colors.black.withOpacity(0.2) ,
              ),
              color:  friend.contestStatus != 'Not-invited' ? Colors.grey.withOpacity(0.5) : isSelected ? const Color(0xFF18786A) : null,
            ),
            child: (isSelected || friend.contestStatus != 'Not-invited')  ? Center(child: Icon(Icons.check, color: friend.contestStatus != 'Not-invited' ? const Color(0xFF3E3E3E) : Colors.white, size: 20)) : null,
          ),
        ],
      ),
    );
  }
}
