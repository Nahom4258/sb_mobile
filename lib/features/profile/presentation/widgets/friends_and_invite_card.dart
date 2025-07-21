import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/referral_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendsAndInviteCard extends StatelessWidget {
  const FriendsAndInviteCard(
      {super.key, required this.userId, required this.friends});

  final String userId;
  final int friends;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                FriendsMainPageRoute().go(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/user.png'),
                      ),
                    ),
                  ),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${friends.toString()} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: friends < 2
                              ? AppLocalizations.of(context)!.friend
                              : AppLocalizations.of(context)!.friends,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF17686A),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          spreadRadius: 6,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_add_alt,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Container(
            height: 3.h,
            width: 1,
            color: Colors.black38,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: ReferalButton(userId: userId),
          )
        ],
      ),
    );
  }
}
