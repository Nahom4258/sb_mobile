import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../core/core.dart';

class CustomContestCardWidget extends StatelessWidget {
  const CustomContestCardWidget({
    super.key,
    required this.isForCreatingCustomContest,
  });

  final bool isForCreatingCustomContest;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF18786A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(
                    contestIcon,
                    color: Colors.white,
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.custom_contests,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.create_contests_and_invite_friends,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (!isForCreatingCustomContest)
              InkWell(
                onTap: () {
                  CustomContestMainPageRoute().go(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Color(0xFF18786A),
                    size: 24,
                  ),
                ),
              ),
            if (isForCreatingCustomContest)
              InkWell(
                onTap: () {
                  CustomContestCreatePageRoute().go(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 4, bottom: 4, right: 8, left: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Color(0xFF18786A),
                        weight: 3,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        AppLocalizations.of(context)!.create,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF18786A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
