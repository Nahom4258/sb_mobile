import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/three_bounce_spinkit.dart';
import '../../../features.dart';
import '../bloc/registerContest/register_contest_bloc.dart';

class CustomContestListCard extends StatelessWidget {
  CustomContestListCard({
    super.key,
    required this.customContest,
    this.isContestInvite = false,
    this.hasRegistered = false,
  });

  final bool isContestInvite;
  final CustomContest customContest;
  bool hasRegistered;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomContestDetailPageRoute(
          customContestId: customContest.id,
        ).go(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60.w,
                    child: Row(
                      children: [
                        Text(
                          customContest.title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(.7),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // if(customContest.owner)
                        // Container(
                        //   margin: const EdgeInsets.only(left: 8),
                        //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xFF18786C).withOpacity(.07),
                        //     borderRadius: BorderRadius.circular(24),
                        //   ),
                        //   child: Text(
                        //     'Owner' ,
                        //     style: GoogleFonts.poppins(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w600,
                        //       color: const Color(0xFF18786C),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    DateFormat('hh:mmaa \nMMM dd, yyyy').format(
                        customContest.startsAt),
                    // 'Dec 15, 2023 08:00PM',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (isContestInvite) {
                  context.read<RegisterToCustomContestInvitesBloc>().add(
                      RegisterToCustomContestInvitesEvent(
                          customContestId: customContest.id)
                  );
                } else {
                  CustomContestDetailPageRoute(
                    customContestId: customContest.id,
                  ).go(context);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: BoxDecoration(
                    color: const Color(0xff18786a),
                    borderRadius: BorderRadius.circular(6)),
                alignment: Alignment.center,
                child: BlocBuilder<RegisterToCustomContestInvitesBloc, RegisterToCustomContestInvitesState>(
                  builder: (context, state) {
                    if(state is RegisterToCustomContestInvitesLoading && state.customContestId == customContest.id) {
                      return const SizedBox(
                        height: 20,
                        child:  ThreeBounceSpinkit(),
                      );
                    } else if (state is RegisterToCustomContestInvitesLoaded && state.customContestId == customContest.id) {
                      // context.read<FetchCustomContestInvitationsBloc>().add(const FetchCustomContestInvitationsEvent());
                      hasRegistered = true;
                    }
                    return Text(
                      isContestInvite
                          ? hasRegistered ? AppLocalizations.of(context)!.registered : AppLocalizations.of(context)!.accept
                          : AppLocalizations.of(context)!.start,
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
