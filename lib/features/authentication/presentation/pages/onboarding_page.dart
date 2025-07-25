import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingPages extends StatefulWidget {
  const OnboardingPages({super.key});

  @override
  State<OnboardingPages> createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _handlePageChange(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onNext(int index) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }

    final Widget indicators = ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == _currentPage
                  ? const Color(0xFFFEA800)
                  : const Color(0xFFD9D9D9),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(width: 10),
      itemCount: 3,
    );

    final List<Widget> pages = [
      OnboardingWidget(
        index: 0,
        indicators: indicators,
        // title: 'Welcome to SkillBridge',
        title: AppLocalizations.of(context)!.welcome_to_skillBridge,
        // description:
        //     'Discover a comprehensive exam preparation tool that helps you ace your university entrance exams',
        description: AppLocalizations.of(context)!
            .discover_a_comprehensive_exam_preparation_tool_that_helps_you_ace_your_ethiopian_university_entrance_exams,
        onNext: onNext,
      ),
      OnboardingWidget(
        index: 1,
        indicators: indicators,
        // title: 'Personalized Quizzes',
        title: AppLocalizations.of(context)!.gamified_learning_experience,
        // description: 'Tailor your study experience with personalized quizzes',
        description: AppLocalizations.of(context)!
            .gamified_learning_experience_with_competitive_weekly_contest_and_custom_quizzes,
        onNext: onNext,
      ),
      OnboardingWidget(
        index: 2,
        indicators: indicators,
        // title: 'Model Exams for Success',
        title: AppLocalizations.of(context)!.model_exams_for_success,
        // description:
        //     'Access to ?a collection of previous year exams with their explanations.',
        description: AppLocalizations.of(context)!
            .access_to_a_collection_of_previous_year_exams_with_their_explanations,
        onNext: onNext, 
      ),
    ];
 
    return Scaffold(
      body: Container(
        color: const Color(0xFF18786A),
        child: Stack(
          children: [
            Image.asset('assets/images/background_lines.png'),
            PageView(
              controller: _pageController,
              onPageChanged: _handlePageChange,
              children: pages,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AnimatedCrossFade(
                  duration:
                      const Duration(milliseconds: 300), // Animation duration
                  crossFadeState: _currentPage == 2
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(InitializeAppEvent());
                                SignupPageRoute().go(context);
                                // context.go(AppRoutes.signup);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFEA800),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Register',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors
                                          .white, // Add the desired color here
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(InitializeAppEvent());
                              LoginPageRoute().go(context);
                              // context.go(AppRoutes.login);
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Login',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFFEA800),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  secondChild: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(InitializeAppEvent());
                          SignupPageRoute().go(context);
                          // context.go(AppRoutes.signup);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Skip',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          onNext(_currentPage + 1);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Next',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
