import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/routes/go_routes.dart';
import 'package:skill_bridge_mobile/features/contest/domain/entities/contest.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/fetch_upcoming_user_contest/fetch_upcoming_user_contest_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/widgets/contestsharecard.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/count_down_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingContestCard extends StatefulWidget {
  const UpcomingContestCard({
    super.key,
    required this.contest,
  });

  final Contest contest;

  @override
  State<UpcomingContestCard> createState() => _UpcomingContestCardState();
}

class _UpcomingContestCardState extends State<UpcomingContestCard> {
  late Timer _timer;
  late int _countDownDuration;

  @override
  void initState() {
    super.initState();
    _countDownDuration = widget.contest.timeLeft;
    if (_countDownDuration < 0) {
      _countDownDuration = 0;
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_countDownDuration > 0) {
          setState(() {
            _countDownDuration--;
          });
        } else {
          context
              .read<FetchUpcomingUserContestBloc>()
              .add(FetchUpcomingContestEvent());
          _timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.contest.live!
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 71, 71),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.sensors_rounded, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          AppLocalizations.of(context)!.live,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.upcoming,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'Poppins'),
                  ),
            Text(
              DateFormat('MMM dd, yyyy').format(widget.contest.startsAt),
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
            )
          ],
        ),
        SizedBox(height: 3.h),
        Text(
          widget.contest.title,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 2.h),
        CountDownCard(
          timeLeft: _countDownDuration,
          forContest: true,
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ContestShareCard(
              color: Colors.white,
              borderTickness: 1,
              width: 40.w,
              contestId: widget.contest.id,
            ),
            widget.contest.hasRegistered != null &&
                    widget.contest.hasRegistered! &&
                    !widget.contest.live!
                ? InkWell(
                    onTap: () {
                      ContestDetailPageRoute(
                        id: widget.contest.id,
                      ).go(context);
                    },
                    child: Container(
                      width: 35.w,
                      height: 5.5.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Color(0xff30377D)),
                          SizedBox(width: 3.w),
                          Text(
                            AppLocalizations.of(context)!.registered,
                            style: const TextStyle(
                                color: Color(0xff30377D),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  )
                : !widget.contest.hasRegistered!
                    ? InkWell(
                        onTap: () {
                          ContestDetailPageRoute(
                            id: widget.contest.id,
                          ).go(context);
                        },
                        child: Container(
                          width: 30.w,
                          height: 5.5.h,
                          alignment: Alignment.center,
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 10.w, vertical: 1.5.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            // widget.contest.live != null && !widget.contest.live!
                            AppLocalizations.of(context)!.register,
                            style: const TextStyle(
                                color: Color(0xff30377D),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          ContestDetailPageRoute(
                            id: widget.contest.id,
                          ).go(context);
                        },
                        child: Container(
                          width: 35.w,
                          height: 5.5.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            // widget.contest.live != null && !widget.contest.live!
                            AppLocalizations.of(context)!.go_to_contest,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Color(0xff30377D),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
        SizedBox(height: 1.h),
        if (widget.contest.liveRegister > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.group, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                '${widget.contest.liveRegister}',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
      ],
    );
  }
}
