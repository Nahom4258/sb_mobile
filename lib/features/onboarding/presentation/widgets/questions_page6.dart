import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/constants.dart';
import '../bloc/onboarding_bloc.dart';
import 'subjects_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entities/subjects_entity.dart';

class QuestionsPageSix extends StatelessWidget {
  const QuestionsPageSix({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              AppLocalizations.of(context)!
                  .are_there_specific_subjects_you_find_more_challenging,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: SizedBox(
              width: 70.w,
              child: BlocBuilder<OnboardingBloc, OnboardingAnswersState>(
                builder: (context, state) {
                  final selectedSubjects = state.subjectsToCover;
                  final userOnboardingState =
                      context.read<OnboardingBloc>().state;

                  List<SubjectsEntity> subjects;

                  if (userOnboardingState.stream == null ||
                      userOnboardingState.stream == 0) {
                    subjects = naturalSubjects;
                  } else if (userOnboardingState.stream == 1) {
                    subjects = socialSubjects;
                  } else {
                    subjects = grade9and10Subjects;
                  }

                  return GridView.builder(
                    itemCount: subjects.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 2.h,
                      childAspectRatio: .75,
                      crossAxisSpacing: 2.w,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return SubjectsCard(
                          image: subjects[index].image,
                          title: subjects[index].title,
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                                  SubjectsChangedEvent(subjectIndex: index),
                                );
                          },
                          selected: selectedSubjects.contains(index));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
