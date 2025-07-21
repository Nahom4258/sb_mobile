import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../bloc/onboarding_bloc.dart';
import 'preparation_level_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionPageOne extends StatelessWidget {
  const QuestionPageOne({super.key});
  @override
  Widget build(BuildContext context) {
    void onGrade9() {
      context.read<OnboardingBloc>().add(const GradeChangeEvent(grade: 9));
    }

    void onGrade10() {
      context.read<OnboardingBloc>().add(const GradeChangeEvent(grade: 10));
    }

    void onGrade11() {
      context.read<OnboardingBloc>().add(const GradeChangeEvent(grade: 11));
    }

    void onGrade12() {
      context.read<OnboardingBloc>().add(const GradeChangeEvent(grade: 12));
    }

    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Column(
        children: [
           Text(
            AppLocalizations.of(context)!.which_grade_are_you,
            
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 3.h,
          ),
          BlocBuilder<OnboardingBloc, OnboardingAnswersState>(
            builder: (context, state) {
              return ListView(
                shrinkWrap: true,
                children: [
                  OnboardingCard(
                      onTap: onGrade9,
                      selected: state.grade == null ? false : state.grade == 9,
                      imageAdress: 'assets/images/g9.png',
                      text: AppLocalizations.of(context)!.grade_9),
                  OnboardingCard(
                      onTap: onGrade10,
                      selected: state.grade == null ? false : state.grade == 10,
                      imageAdress: 'assets/images/g10.png',
                      text: AppLocalizations.of(context)!.grade_10),
                  OnboardingCard(
                      onTap: onGrade11,
                      selected: state.grade == null ? false : state.grade == 11,
                      imageAdress: 'assets/images/g11.png',
                      text: AppLocalizations.of(context)!.grade_11),
                  OnboardingCard(
                      onTap: onGrade12,
                      selected: state.grade == null ? false : state.grade == 12,
                      imageAdress: 'assets/images/g12.png',
                      text: AppLocalizations.of(context)!.grade_12)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
