import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/onboarding/presentation/widgets/questions_page_8.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/schoolInfoBloc/school_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/select_language_widget.dart';
import '../../../../core/core.dart';

import '../../../features.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingQuestionPages extends StatefulWidget {
  const OnboardingQuestionPages({super.key});

  @override
  State<OnboardingQuestionPages> createState() =>
      _OnboardingQuestionPagesState();
}

class _OnboardingQuestionPagesState extends State<OnboardingQuestionPages> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool requiredFieldNotFilled = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    context.read<SchoolBloc>().add(GetSchoolInformationEvent());
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final onboardingQuestionWidgets = [
    const ChangeLanguageWidget(),
    const QuestionPageOne(),
    const QuestionsPageFive(),
  
    // const QuestionsPageTwo(),
    // const QuestionPageThree(),
    // const QuestionsPageFour(),

    OnboardingSchoolsPage(),
    const QuestionsPageSix(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w, bottom: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentIndex == 0
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.transparent,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            _currentIndex - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                      ),
                // if (_currentIndex != onboardingQuestionWidgets.length)
                SizedBox(
                  width: 60.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: LinearProgressIndicator(
                      value: (_currentIndex + 1) /
                          onboardingQuestionWidgets
                              .length, // userProgress should be a double between 0.0 and 1.0
                      minHeight: 6,
                      backgroundColor: const Color(0xffE7F0EF),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xff18786A),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
            SizedBox(height: 4.h),
            Expanded(
              child: SizedBox(
                // height: _currentIndex == 6 ? 90.h : 75.h,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: onboardingQuestionWidgets,
                  // children: [
                  //
                  //   // QuestionsPageSeven(),
                  // ],
                ),
              ),
            ),

            BlocBuilder<OnboardingBloc, OnboardingAnswersState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (requiredFieldNotFilled)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: const Text(
                          'Please ensure all required fields are filled out before proceeding!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 252, 52, 26),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        if (_currentIndex ==
                                onboardingQuestionWidgets.length - 1 &&
                            !state.validResponse) {
                          return;
                        } else if (_currentIndex ==
                            onboardingQuestionWidgets.length - 1) {
                          context.read<OnboardingBloc>().add(
                                OnboardingQuestionsResponseSubmittedEvent(),
                              );
                        }
                        if (_currentIndex <
                            onboardingQuestionWidgets.length - 1) {
                          if (_currentIndex == 1 && state.grade == null) {
                            setState(() {
                              requiredFieldNotFilled = true;
                            });
                            return;
                            
                            // }else if (_currentIndex == 2 &&
                            //     state.preparationMethod == null) {
                            //   setState(() {
                            //     requiredFieldNotFilled = true;
                            //   });
                            //   return;
                            // } else if (_currentIndex == 3 &&
                            //     state.dedicationTime == null) {
                            //   setState(() {
                            //     requiredFieldNotFilled = true;
                            //   });
                            //   return;
                            // } else if (_currentIndex == 4 &&
                            //     state.userMotive == null) {
                            //   setState(() {
                            //     requiredFieldNotFilled = true;
                            //   });
                            //   return;
                          } else if (_currentIndex == 2 &&
                              state.stream == null) {
                            setState(() {
                              requiredFieldNotFilled = true;
                            });
                            return;
                          } else if (_currentIndex == 3 &&
                              (state.highSchool == null ||
                                 
                                  state.region == null)) {
                            setState(() {
                              requiredFieldNotFilled = true;
                            });
                            return;
                          }
                          setState(() {
                            requiredFieldNotFilled = false;
                          });
                          _pageController.animateToPage(
                            _currentIndex + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );

                          context.read<OnboardingBloc>().add(
                                OnContinueButtonPressedEvent(),
                              );
                        }
                      },
                      child: Container(
                        width: _currentIndex == onboardingQuestionWidgets.length
                            ? 0
                            : 40.w,
                        height:
                            _currentIndex == onboardingQuestionWidgets.length
                                ? 0
                                : 6.h,
                        margin: EdgeInsets.only(top: 2.h),
                        // padding: EdgeInsets.symmetric(
                        //     horizontal: 6.w, vertical: 2.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _currentIndex == 3 && !state.validResponse
                                ? Colors.grey
                                : const Color(0xff18786A)),
                        child: BlocConsumer<OnboardingBloc,
                            OnboardingAnswersState>(
                          listener: (context, state) {
                            if (state.responseSubmitted) {
                              CubeAnimationPageRoute().go(context);
                            }
                          },
                          builder: (context, state) {
                            if (state.responseSubmitting) {
                              return const SpinKitThreeBounce(
                                color: Colors.white,
                                size: 20,
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _currentIndex <
                                          onboardingQuestionWidgets.length - 1
                                      ? AppLocalizations.of(context)!.continue_button
                                      : AppLocalizations.of(context)!.lets_start,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
            //     : const SizedBox()
          ],
        ),
      ),
    );
  }
}
