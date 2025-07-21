import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../features.dart';
import 'package:skill_bridge_mobile/core/core.dart';

import 'package:skill_bridge_mobile/features/profile/presentation/bloc/logout/logout_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileHeader extends StatelessWidget {
  final int? grade;
  final String firstName;
  final String lastName;
  final String avatar;

  const ProfileHeader({
    super.key,
    required this.grade,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogedOutState) {
          LoginPageRoute().go(context);
        }
      },
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(avatar),
                      fit: BoxFit.cover,
                    )),
              ),
              if (grade != null)
                Positioned(
                  bottom: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/profileBadge.png',
                        height: 5.h,
                        width: 110,
                      ),
                      Positioned(
                        top: .75.h,
                        child: Text(
                          // 'Grade ${grade.toString()}',
                          AppLocalizations.of(context)!.gread(grade.toString()),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$firstName $lastName',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // SizedBox(height: .5.h),
                InkWell(
                  onTap: () {
                    EditProfilePageRoute().go(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.edit_profile,
                    style: const TextStyle(
                        color: Color(0xff18786a),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 2.w),
          IconButton(
            onPressed: () {
              // _showConfirmationDialog(context);
              SettingsPageRoute().go(context);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
