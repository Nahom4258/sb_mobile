import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skill_bridge_mobile/core/utils/create_links.dart';
import 'package:skill_bridge_mobile/core/widgets/popup_widgets/share_an_app.dart';
import 'package:skill_bridge_mobile/core/widgets/progress_indicator2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userRefferalInfoCubit/user_refferal_info_cubit.dart';

class ReferalButton extends StatefulWidget {
  const ReferalButton({
    super.key,
    required this.userId,
    this.numberOfReferals,
  });
  final String userId;
  final int? numberOfReferals;

  @override
  State<ReferalButton> createState() => _ReferalButtonState();
}

class _ReferalButtonState extends State<ReferalButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          loading = true;
        });
        DynamicLinks.createReferalLink(userId: widget.userId)
            .then((referalLink) {
          setState(() {
            loading = false;
          });
          InviteAnAppDialog(context, referalLink);
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .75.h),
        decoration: BoxDecoration(
          color: const Color(0xff18786a),
          borderRadius: BorderRadius.circular(5),
        ),
        child: loading
            ? const CustomLinearProgressIndicator(
                color: Colors.white,
                size: 18,
              )
            : Text(
                AppLocalizations.of(context)!.invite_friends,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
