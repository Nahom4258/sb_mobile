import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'preparation_level_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/onboarding_bloc.dart';

class QuestionsPageFive extends StatelessWidget {
  const QuestionsPageFive({super.key});

  @override
  Widget build(BuildContext context) {
    void onNaturalSelect() {
      context.read<OnboardingBloc>().add(const StreamChangedEvent(stream: 0));
    }

    void onSocialSelect() {
      context.read<OnboardingBloc>().add(const StreamChangedEvent(stream: 1));
    }

    void onBothSelect() {
      context.read<OnboardingBloc>().add(const StreamChangedEvent(stream: 2));
    }

    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              AppLocalizations.of(context)!.which_stream_are_you,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          BlocBuilder<OnboardingBloc, OnboardingAnswersState>(
            builder: (context, state) {
              final stream = state.stream;
              return ListView(
                shrinkWrap: true,
                children: [
                  OnboardingCard(
                      onTap: onNaturalSelect,
                      selected: stream == null ? false : stream == 0,
                      imageAdress:
                          'assets/images/onboarding/natural_science.png',
                      text: AppLocalizations.of(context)!.natural_science),
                  OnboardingCard(
                      onTap: onSocialSelect,
                      selected: stream == null ? false : stream == 1,
                      imageAdress:
                          'assets/images/onboarding/socrial_science.png',
                      text: AppLocalizations.of(context)!.social_science),
                  OnboardingCard(
                      onTap: onBothSelect,
                      selected: stream == null ? false : stream == 2,
                      imageAdress:
                          'assets/images/onboarding/socrial_science.png',
                      text: AppLocalizations.of(context)!.both),
                  Text(
                    AppLocalizations.of(context)!.both_description,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
