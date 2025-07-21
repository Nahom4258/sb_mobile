import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/config/markdown_generator.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/bloc/routerBloc/router_bloc.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/pages/custom_contest_main_page.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.messageContent,
    required this.isMyMessage,
    required this.time,
    this.tag,
  });

  final String messageContent;
  final bool isMyMessage;
  final DateTime time;
  final String? tag;
  @override
  Widget build(BuildContext context) {
    final formattedTimeWithAmPm = DateFormat('hh:mm a').format(time);

    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: messageContent == ''
          ? Container()
          : Column(
              crossAxisAlignment: isMyMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: isMyMessage ? 70.w : 90.w,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(colors: [
                      isMyMessage
                          ? const Color.fromARGB(255, 232, 232, 232)
                          : Colors.transparent,
                      isMyMessage
                          ? const Color.fromARGB(255, 232, 232, 232)
                          : Colors.transparent,
                    ], stops: [
                      0.0,
                      1.0
                    ]),
                    // color: isMyMessage ? Colors.white : Color(0xFF44A092),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isMyMessage ? 20 : 0),
                      bottomRight: Radius.circular(isMyMessage ? 0 : 20),
                    ),
                  ),
                  child: !isMyMessage
                      ? Container(
                          width: 100.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 45,
                                height: 45,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Image.asset(
                                      'assets/images/profile_avatar.png'),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Container(
                                width: 70.w,
                                child: Column(
                                  children: [
                                    MarkdownWidget(
                                      shrinkWrap: true,
                                      data: messageContent,
                                      config: MarkdownConfig.defaultConfig,
                                      markdownGenerator: MarkdownGenerator(
                                        generators: [latexGenerator],
                                        inlineSyntaxList: [LatexSyntax()],
                                        richTextBuilder: (span) => Text.rich(
                                          span,
                                          style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 38, 38, 38),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              height: 1.5),
                                        ),
                                      ),
                                    ),
                                    if (tag != null) SizedBox(height: 1.h),
                                    if (tag != null)
                                      BlocBuilder<RouterBloc, RouterState>(
                                        builder: (context, state) {
                                          if (state is RouterPopulatedState) {
                                            final router = state.router;
                                            return InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                if (tag == 'Contest') {
                                                  context
                                                      .read<HomePageNavBloc>()
                                                      .add(
                                                          const HomePageNavEvent(
                                                              index: 0));
                                                  router.go('/');
                                                } else if (tag == 'Course') {
                                                  context
                                                      .read<HomePageNavBloc>()
                                                      .add(
                                                          const HomePageNavEvent(
                                                              index: 1));
                                                  router.go('/');
                                                } else if (tag == 'Home') {
                                                  context
                                                      .read<HomePageNavBloc>()
                                                      .add(
                                                          const HomePageNavEvent(
                                                              index: 2));
                                                  router.go('/');
                                                } else if (tag == 'Exam') {
                                                  context
                                                      .read<HomePageNavBloc>()
                                                      .add(
                                                          const HomePageNavEvent(
                                                              index: 3));
                                                  router.go('/');
                                                } else if (tag ==
                                                    'Leaderboard') {
                                                  context
                                                      .read<HomePageNavBloc>()
                                                      .add(
                                                          const HomePageNavEvent(
                                                              index: 4));
                                                  router.go('/');
                                                } else if (tag == 'Profile') {
                                                  router.go('/profile');
                                                } else if (tag == 'Settings') {
                                                  router.go('/settings');
                                                } else if (tag == 'Friends') {
                                                  router.go('/friends');
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 70.w,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0,
                                                            vertical: 12.0),
                                                    // height: 10.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color.fromARGB(
                                                          255, 237, 237, 237),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 1,
                                                          color: Colors.black
                                                              .withOpacity(.04),
                                                          spreadRadius: 0,
                                                          offset: const Offset(
                                                              2, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            'Go to $tag page',
                                                            maxLines: 3,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 6.0,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Colors.black87,
                                                          size: 15,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SelectableText(
                          messageContent,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: Color.fromARGB(255, 49, 49, 49),
                          ),
                        ),
                ),
                SizedBox(height: 1.h),
                isMyMessage
                    ? Text(
                        formattedTimeWithAmPm.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF757575),
                        ),
                      )
                    : Container(),
                SizedBox(height: 1.h),
              ],
            ),
    );
  }
}
