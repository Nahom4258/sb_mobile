import 'dart:math';

// import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/utils/connectivity_service.dart';
import 'package:skill_bridge_mobile/core/widgets/doubleback.dart';
import '../../features/features.dart';
import '../../features/profile/presentation/bloc/logout/logout_bloc.dart';
import '../core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui' as ui;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // const MyHomePage({super.key, this.index});
  // final int? index;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  late int _currentIndex;

  bool isOfflineWidgetShown = true;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    // _currentIndex = widget.index != null ? widget.index! : 2;
    _currentIndex = context.read<HomePageNavBloc>().state.index;
    _pageController = PageController(initialPage: _currentIndex);
    context.read<ShowRefreshTokenPopupBloc>().add(const ShowRefreshTokenPopupEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   navigateToPageIndexFromUrl();
  // }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    context.read<HomePageNavBloc>().add(HomePageNavEvent(index: index));
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    navigateToPageIndexFromUrl();
  }

  void _navigateToSettings() {
    setState(() {
      _currentIndex = 2; // Set the index of SettingsPage
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void removeOfflineWidget() {
    setState(() {
      isOfflineWidgetShown = false;
    });
  }

  void goToDownloadedCourses() {
    setState(() {
      tabIndex = 2;
      _currentIndex = 1;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    removeOfflineWidget();
  }

  void goToDownloadedMocks() {
    setState(() {
      _currentIndex = 3;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    DownloadedMockExamsPageRoute().go(context);
    removeOfflineWidget();
  }

  void navigateToPageIndexFromUrl() {
    final idx = context.read<HomePageNavBloc>().state.index;
    setState(() {
      _currentIndex = idx;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.animateToPage(
        idx,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var isOffline = !context.watch<ConnectivityService>().isOnline;
    if (!isOffline) {
      isOfflineWidgetShown = true;
    }
    // isFirstTime is used to use the navigate to a page index only first time the page builds

    return DoubleBack(
      message: 'double click to exit the app',
      child: Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const ContestsMainPage(),
                    MyCoursesPage(tabIndex: tabIndex),
                    const DynamicHomePage(),
                    const ExamsPage(),
                    const UserLeaderboardPage(),
                  ],
                ),
                if ((isOfflineWidgetShown == isOffline) && isOffline)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: GoToDownloadsWidget(
                      removeWidget: removeOfflineWidget,
                      goToCourses: goToDownloadedCourses,
                      goToMock: goToDownloadedMocks,
                    ),
                  ),
                BlocBuilder<ShowRefreshTokenPopupBloc, ShowRefreshTokenPopupState>(
                  builder: (context, state) {
                    if(state is ShowRefreshTokenPopupStateLoaded && state.showPopup) {
                      return BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: 8.0,
                          sigmaY: 8.0,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            // Colors.grey.shade200.withOpacity(0.9),
                          ),
                          child: Center(
                            child: Container(
                              width: 90.w,
                              height: 60.w,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF18786C).withOpacity(.96),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Session Expired',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Your session has expired. Please re-login to use our app again',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 36),
                                    BlocListener<LogoutBloc, LogoutState>(
                                      listener: (context, state) {
                                        if(state is LogedOutState) {
                                          LoginPageRoute().go(context);
                                        }
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          context
                                              .read<LogoutBloc>()
                                              .add(DispatchLogoutEvent());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          child: Text(
                                            'Log out',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF18786A)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
            bottomNavigationBar: CircleNavBar(
              activeIcons: const [
                ActiveBttomNavWidget(icon: contestIcon),
                ActiveBttomNavWidget(icon: courseIcon),
                ActiveBttomNavWidget(icon: homeIcon),
                ActiveBttomNavWidget(icon: examsIcon),
                ActiveBttomNavWidget(icon: leaderboardIcon),
              ],
              inactiveIcons: [
                BottomNavCard(
                    icon: contestIcon, text: AppLocalizations.of(context)!.contest),
                BottomNavCard(
                    icon: courseIcon, text: AppLocalizations.of(context)!.courses),
                BottomNavCard(
                    icon: homeIcon, text: AppLocalizations.of(context)!.home),
                BottomNavCard(
                    icon: examsIcon, text: AppLocalizations.of(context)!.exams),
                BottomNavCard(
                    icon: leaderboardIcon,
                    text: AppLocalizations.of(context)!.leaderboard),
              ],
              color: Colors.white,
              height: 8.h,
              circleWidth: 8.h,
              activeIndex: _currentIndex,
              onTap: (index) {
                _currentIndex = index;
                _pageController.jumpToPage(_currentIndex);
              },
              cornerRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              tabDurationMillSec: 0,
              iconDurationMillSec: 0,
              tabCurve: Curves.linear,
              iconCurve: Curves.linear,
              circleColor: const Color(0xff18786a),
              circleShadowColor: const Color(0xff18786a).withOpacity(.5),
            ),
          ),

        ],
      ),
    );
  }
}

class ActiveBttomNavWidget extends StatelessWidget {
  final String icon;

  const ActiveBttomNavWidget({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.h,
      padding: const EdgeInsets.all(1),
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.scaleDown,
        color: Colors.white,
      ),
    );
  }
}

class BottomNavCard extends StatelessWidget {
  final String icon;
  final String text;
  const BottomNavCard({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2.75.h,
          padding: const EdgeInsets.all(1),
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.scaleDown,
            color: Colors.black.withOpacity(.7),
          ),
        ),
        SizedBox(height: .5.h),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(.7),
          ),
        ),
      ],
    );
  }
}
