import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_bridge_mobile/core/core.dart';

class FriendsNotFoundWidget extends StatelessWidget {
  const FriendsNotFoundWidget({
    super.key,
    required this.customContestId,
  });

  final String customContestId;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Image.asset('assets/images/friends_not_found.png'),
        const SizedBox(height: 12),
        Text(
          'Opps you haven\'t invited any of your friends. Press the button below to invite your friends',
          style: GoogleFonts.poppins(
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: (){
            CustomContestInviteFriendsPageRoute(customContestId: customContestId).go(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration:  BoxDecoration(
                    color: const Color(0xFF18786A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, weight: 2, size: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  'Invite Friends',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF18786A),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
