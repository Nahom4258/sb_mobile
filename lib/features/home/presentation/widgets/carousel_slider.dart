import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/core/routes/go_routes.dart';
import 'package:skill_bridge_mobile/core/utils/create_links.dart';
import 'package:skill_bridge_mobile/core/widgets/popup_widgets/share_an_app.dart';
import 'package:skill_bridge_mobile/core/widgets/progress_indicator2.dart';
import 'package:skill_bridge_mobile/features/contest/domain/entities/contest.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/fetch_upcoming_user_contest/fetch_upcoming_user_contest_bloc.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/home/presentation/widgets/time_count_down_for_national_exams.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userRefferalInfoCubit/user_refferal_info_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CarouselSliderForUpcommingEvents extends StatefulWidget {
  const CarouselSliderForUpcommingEvents({Key? key}) : super(key: key);

  @override
  _CarouselSliderForUpcommingEventsState createState() =>
      _CarouselSliderForUpcommingEventsState();
}

class _CarouselSliderForUpcommingEventsState
    extends State<CarouselSliderForUpcommingEvents> {
  final List<Widget> _carouselItems = [];
  bool isShareInProgress = false;

  @override
  void initState() {
    super.initState();
    //add contest card if available
    _carouselItems.add(const ShareCardOnCarousel());
    _carouselItems.add(CreateCustomeContest());
    // _carouselItems.add(nationalExamsCard());
  }

  Widget nationalExamsCard() {
    return BlocBuilder<GetExamDateBloc, GetExamDateState>(
      builder: (context, state) {
        if (state is ExamDateState &&
            state.status == GetExamDateStatus.loaded) {
          final targetDate = state.targetDate!.date;

          return UpcommingEventsCard(
            title: AppLocalizations.of(context)!.national_exam,
            date: targetDate,
            isForNationalExam: true,
            leftWidget: TimeCountDownWidget(
              targetDate: targetDate,
            ),
            // leftWidget: CountDownCardForNationalExams(
            //   timeLeft: 0,
            //   months: months.toString().padLeft(2, '0'),
            //   days: days.toString().padLeft(2, '0'),
            // ),
          );
        }
        return Container();
      },
    );
  }

  Widget contestCard({required Contest contest}) {
    final leftWidget = InkWell(
      onTap: () {
        if (contest.hasRegistered!) {
          final route = 'contest/${contest.id}';
          final userId = context.read<GetUserBloc>().state
                  is GetUserCredentialState
              ? (context.read<GetUserBloc>().state as GetUserCredentialState)
                  .userCredential
                  ?.id
              : null;
          DynamicLinks.createDynamicLink(
            route: route,
            imageURL:
                'https://res.cloudinary.com/djrfgfo08/image/upload/v1719494765/SkillBridge/mobile_team_icons/hqwdfje4jjee3doxjlu7.jpg',
            description: contestDescription,
            userId: userId,
          ).then((value) {
            setState(() {
              isShareInProgress = false;
            });
            Share.share(
              value,
              subject: 'SkillBridge contest',
            );
          });
        } else {
          ContestDetailPageRoute(id: contest.id).go(context);
        }
      },
      child: Container(
        height: 5.h,
        width: 20.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: isShareInProgress
            ? const CustomProgressIndicator(
                size: 15,
              )
            : Text(
                contest.hasRegistered!
                    ? AppLocalizations.of(context)!.invite
                    : AppLocalizations.of(context)!.register,
                style: const TextStyle(
                    color: Color(0xff306496),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
    return UpcommingEventsCard(
      title: contest.title,
      date: contest.startsAt,
      leftWidget: leftWidget,
    );
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FetchUpcomingUserContestBloc,
          FetchUpcomingUserContestState>(
        listener: (context, state) {
          if (state is UpcomingContestFetchedState &&
              state.upcomingContes != null) {
            _carouselItems.add(contestCard(contest: state.upcomingContes!));
            setState(() {});
          }
        },
        child: Column(
          children: [
            CarouselSlider(
              items: _carouselItems,
              options: CarouselOptions(
                height: 11.4.h,
                enlargeCenterPage: true,

                viewportFraction: 1.0,
                // enableInfiniteScroll: true,
                autoPlay: _carouselItems.length > 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 1.h),
            Container(
                alignment: Alignment.center,
                width: 10.w,
                height: 2.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? const Color(0xff18786a)
                          : Colors.grey.shade300,
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 1.5.w,
                  ),
                  itemCount: _carouselItems.length,
                )),
          ],
        ),
      ),
    );
  }
}

class UpcommingEventsCard extends StatelessWidget {
  const UpcommingEventsCard({
    super.key,
    required this.title,
    required this.date,
    required this.leftWidget,
    this.isForNationalExam,
  });
  final String title;
  final DateTime date;
  final Widget leftWidget;
  final bool? isForNationalExam;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: const Color(0xff306496),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.notifications_on_rounded,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(width: 3.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (isForNationalExam != null && isForNationalExam!)
                        ? 20.w
                        : 50.w,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                      ),
                      maxLines:
                          (isForNationalExam != null && isForNationalExam!)
                              ? 2
                              : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isForNationalExam == null)
                    Text(
                      DateFormat('EEEE MMMM d, y').format(date),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                ],
              ),
            ],
          ),
          leftWidget,
        ],
      ),
    );
  }
}

class CreateCustomeContest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final leftWidget = InkWell(
      onTap: () {
        CustomContestMainPageRoute().go(context);
      },
      child: Container(
        height: 5.h,
        width: 20.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Text(
          AppLocalizations.of(context)!.create,
          style: const TextStyle(
              color: Color(0xff306496),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
   return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Color(0xff306496),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                    contestIcon,
                    color: Colors.white,
                    width: 36,
                    height: 36,
                  ),
              SizedBox(width: 3.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50.w,
                    child: const Text(
                      "Create Custom Contest and Invite your Friends!",
                      style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                      ),
                      maxLines:2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
          leftWidget,
        ],
      ),
    );
  }
}

class ShareCardOnCarousel extends StatefulWidget {
  const ShareCardOnCarousel({
    super.key,
  });

  @override
  State<ShareCardOnCarousel> createState() => _ShareCardOnCarouselState();
}

class _ShareCardOnCarouselState extends State<ShareCardOnCarousel> {
  bool isShareInProgress = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRefferalInfoCubit, UserRefferalInfoState>(
      builder: (context, state) {
        if (state is UserRefferalInfoLoaded) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: const Color(0xff306496),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.notifications_on_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 3.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            AppLocalizations.of(context)!
                                .refer_a_friend_earn_10_birr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.total_referrals,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              state.userRefferalInfoEntity.refferalCount
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                BlocBuilder<GetUserBloc, GetUserState>(
                  builder: (context, userState) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          isShareInProgress = true;
                        });
                        if (userState is GetUserCredentialState &&
                            userState.status == GetUserStatus.loaded) {
                          DynamicLinks.createReferalLink(
                                  userId: userState.userCredential!.id)
                              .then((referalLink) {
                            setState(() {
                              isShareInProgress = false;
                            });
                            InviteAnAppDialog(context, referalLink);
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 5.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: isShareInProgress
                            ? const CustomLinearProgressIndicator(
                                size: 15,
                              )
                            : Text(
                                AppLocalizations.of(context)!.refer,
                                style: TextStyle(
                                  color: Color(0xff306496),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
