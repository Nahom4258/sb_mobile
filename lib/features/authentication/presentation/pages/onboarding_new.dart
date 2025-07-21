import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class OnBoardingPageNew extends StatefulWidget {
  const OnBoardingPageNew({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPageNew> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    introKey.currentState?.skipToEnd();
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w300,fontFamily: 'Poppins');

    final pageDecoration = PageDecoration(
        bodyAlignment: Alignment.bottomCenter,
        imageAlignment: Alignment.bottomCenter,
        imageFlex: 3,
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600,color: Colors.white, fontFamily: 'Poppins'),
        bodyTextStyle: bodyStyle,
        bodyPadding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 0.0),
        // bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        // imagePadding: EdgeInsets.zero,
        boxDecoration: BoxDecoration(
            //  color: Color(0xff18786a),
            image: DecorationImage(
                image: AssetImage('assets/images/background_lines.png'))));

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Color(0xff18786a),
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,

      pages: [
        PageViewModel(
          title: 'Welcome to SkillBridge',
          body:
              'A personalized AI-powered learning platform, delivering quality education and study tools for all Ethiopian high school students.',
          image: _buildImage('onboarding_5.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Expert-approved content",
          body:
              "SkillBridge offers AI-curated, expert-approved study resources and exam materials to support your academic success.",
          image: _buildImage('Onboarding_6.png',350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Gamified learning experience",
          body:
              "Join weekly contests, compete with others, and rise on the leaderboards for a fun and rewarding experience.",
          image: _buildImage('onboarding_8.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Unlock Your Potential with Personalized Learning",
          // image: _buildImage('onboarding_3.png'),
          bodyWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Column(
              children: [
                Image.asset('assets/images/Onboarding_9.png', width: 350),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Adjust the radius as needed
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: RichText(
                            text: TextSpan(
                              text: 'Register',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    Colors.white, // Add the desired color here
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
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 10,
          ),
        ),
      ],
      // onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showDoneButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.white)),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      
      curve: Curves.fastLinearToSlowEaseIn,
      // controlsPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFffffff),
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xffFFC107),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color(0xff18786a),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
      ),
    );
  }
}


