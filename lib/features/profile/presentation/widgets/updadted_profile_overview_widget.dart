import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/updated_user_records.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverviewWidget extends StatelessWidget {
  final int chapterNum;
  final int topicsNum;
  final double points;
  final int questionsNum;
  const OverviewWidget({
    super.key,
    required this.chapterNum,
    required this.topicsNum,
    required this.points,
    required this.questionsNum,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: UpdatedSingleRecordCard(
                    imageColor: const Color(0xffa4a5e2),
                    imagePath: 'assets/images/Book.png',
                    number: chapterNum.toDouble(),
                    text: AppLocalizations.of(context)!.chapters_completed),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                width: 40.w,
                child: UpdatedSingleRecordCard(
                    imageColor: const Color(0xffd876aa),
                    imagePath: 'assets/images/Star.png',
                    number: points,
                    text: AppLocalizations.of(context)!.points),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: UpdatedSingleRecordCard(
                    imageColor: const Color(0xffb9b9b9),
                    imagePath: 'assets/images/Overview.png',
                    number: topicsNum.toDouble(),
                    text: AppLocalizations.of(context)!.topics_completed),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                width: 40.w,
                child: UpdatedSingleRecordCard(
                    imageColor: const Color(0xff84abf4),
                    imagePath: 'assets/images/askQuestion.png',
                    number: questionsNum.toDouble(),
                    text: AppLocalizations.of(context)!.questions_solved),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
