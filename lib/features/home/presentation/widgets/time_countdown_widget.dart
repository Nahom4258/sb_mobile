// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/count_down_item_for_national_exam.dart';

class TimeCountDownWidget extends StatefulWidget {
  const TimeCountDownWidget({
    Key? key,
    required this.targetDate,
  }) : super(key: key);

  final DateTime targetDate;

  @override
  State<TimeCountDownWidget> createState() => _TimeCountDownWidgetState();
}

class _TimeCountDownWidgetState extends State<TimeCountDownWidget> {
  late Timer _timer;
  late int _countDownDuration;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant TimeCountDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetDate != widget.targetDate) {
      _resetTimer();
    }
  }

  void _startTimer() {
    _countDownDuration = widget.targetDate.difference(DateTime.now()).inSeconds;
    if (_countDownDuration < 0) {
      _countDownDuration = 0;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDownDuration > 0) {
        setState(() {
          _countDownDuration--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = (_countDownDuration ~/ 86400).toString().padLeft(2, '0');
    final hours =
        ((_countDownDuration ~/ 3600) % 24).toString().padLeft(2, '0');
    final minutes =
        ((_countDownDuration ~/ 60) % 60).toString().padLeft(2, '0');

    final seconds = (_countDownDuration % 60).toString().padLeft(2, '0');
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff306496),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CounrDownItemCard(
                countDown: days,
                label: AppLocalizations.of(context)!.days,
              ),
              const SizedBox(width: 4),
              CounrDownItemCard(
                countDown: hours,
                label: AppLocalizations.of(context)!.hours,
              ),
              const SizedBox(width: 4),
              CounrDownItemCard(
                countDown: minutes,
                label: AppLocalizations.of(context)!.minutes,
              ),
              const SizedBox(width: 4),
              CounrDownItemCard(
                countDown: seconds,
                label: AppLocalizations.of(context)!.seconds,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
