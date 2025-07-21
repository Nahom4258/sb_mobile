import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skill_bridge_mobile/core/constants/app_strings.dart';
import 'package:skill_bridge_mobile/core/utils/create_links.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContestShareCard extends StatefulWidget {
  const ContestShareCard({
    super.key,
    required this.color,
    required this.borderTickness,
    required this.width,
    required this.contestId,
  });
  final Color color;
  final double borderTickness;
  final double width;
  final String contestId;

  @override
  State<ContestShareCard> createState() => _ContestShareCardState();
}

class _ContestShareCardState extends State<ContestShareCard> {
  bool isShareInProgress = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        print('Current route:- ${GoRouter.of(context).location}');
        final userId =
            context.read<GetUserBloc>().state is GetUserCredentialState
                ? (context.read<GetUserBloc>().state as GetUserCredentialState)
                    .userCredential
                    ?.id
                : null;
        if (isShareInProgress) return;
        setState(() {
          isShareInProgress = true;
        });
        DynamicLinks.createDynamicLink(
          route: '/contest/${widget.contestId}',
          imageURL:
              'https://res.cloudinary.com/djrfgfo08/image/upload/v1719494765/SkillBridge/mobile_team_icons/hqwdfje4jjee3doxjlu7.jpg',
          // title: 'SkillBridge Contest',
          description: contestDescription,
          userId: userId,
        ).then((value) {
          setState(() {
            isShareInProgress = false;
          });
          Share.share(
            value,
            subject: "SkillBridge Contest",
          );
        });
      },
      child: Container(
        width: widget.width,
        height: 5.5.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          border: Border.all(color: widget.color, width: widget.borderTickness),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.person_outline,
              color: widget.color,
            ),
            Text(
              AppLocalizations.of(context)!.invite_friends,
              style: TextStyle(color: widget.color, fontFamily: 'Poppins'),
            )
          ],
        ),
      ),
    );
  }
}
