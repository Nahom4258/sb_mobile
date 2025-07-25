import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_bridge_mobile/core/routes/routes.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/pages/notification_page.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/pages/cube_animation_page.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/pages/onboarding_new.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/pages/first_name.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/pages/bookmarked_content_page.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/pages/bookmarked_question_page.dart';
import 'package:skill_bridge_mobile/features/course/presentation/pages/channel_videos_page.dart';
import 'package:skill_bridge_mobile/features/course/presentation/pages/content_final_page.dart';
import 'package:skill_bridge_mobile/features/course/presentation/pages/content_page.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/pages/add_friends_page.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/pages/friends_page.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/pages/cashout_page.dart';

import 'package:skill_bridge_mobile/features/profile/presentation/pages/leaderbaord_detail.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/pages/profile_edit_page.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/pages/settings_page.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/pages/updated_profile_page.dart';
import 'package:skill_bridge_mobile/features/question/presentation/pages/shared_question_page.dart';

import '../../features/bookmarks/domain/entities/bookmarked_contents.dart';
import '../../features/bookmarks/domain/entities/bookmarked_questions.dart';
import '../../features/features.dart';
import '../../features/question/presentation/pages/end_of_chapter_question_page.dart';
import '../../features/question/presentation/pages/end_of_questions_result_page.dart';
import '../core.dart';

part 'go_routes.g.dart';

@TypedGoRoute<OnboardingPagesRoute>(
  name: 'onboarding',
  path: '/onboarding',
)
class OnboardingPagesRoute extends GoRouteData {
  OnboardingPagesRoute();

  @override
  // Widget build(context, state) => const OnboardingPages();
  Widget build(context, state) => const OnBoardingPageNew();
}

@TypedGoRoute<LoginPageRoute>(
  name: 'login',
  path: '/login',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<ForgotPasswordPageRoute>(
      name: 'forgotPassword',
      path: 'forgot-password',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<ForgotPasswordOtpPageRoute>(
          name: 'forgotPasswordOtp',
          path: 'otp',
        ),
        TypedGoRoute<ChangePasswordPageRoute>(
          name: 'changePassword',
          path: 'change-password',
        ),
      ],
    ),
    TypedGoRoute<NewPasswordConfirmedPageRoute>(
      name: 'newPasswordConfirmed',
      path: 'new-password-confirmed',
    ),
  ],
)
class LoginPageRoute extends GoRouteData {
  LoginPageRoute();

  @override
  Widget build(context, state) => const LoginPage();
}
@TypedGoRoute<FirstNamePageRoute>(
  name: 'firstName',
  path: '/firstName',
)
class FirstNamePageRoute extends GoRouteData {
  FirstNamePageRoute();
  @override
  Widget build(context, state) => const FirstName();
}

class ForgotPasswordPageRoute extends GoRouteData {
  ForgotPasswordPageRoute();

  @override
  Widget build(context, state) => const ForgotPasswordPage();
}

class ForgotPasswordOtpPageRoute extends GoRouteData {
  ForgotPasswordOtpPageRoute({
    required this.emailOrPhoneNumber,
  });

  final String emailOrPhoneNumber;

  @override
  Widget build(context, state) => OTPPage(
        emailOrPhoneNumber: emailOrPhoneNumber,
        from: ForgotPasswordPageRoute().location,
      );
}

class ChangePasswordPageRoute extends GoRouteData {
  ChangePasswordPageRoute();

  @override
  Widget build(context, state) => const ChangePasswordPage();
}

class NewPasswordConfirmedPageRoute extends GoRouteData {
  NewPasswordConfirmedPageRoute();

  @override
  Widget build(context, state) => const NewPasswordConfirmedPage();
}

@TypedGoRoute<SignupPageRoute>(
  name: 'signup',
  path: '/signup',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SignupOtpPageRoute>(
      name: 'signupOtp',
      path: 'otp',
    ),
  ],
)
class SignupPageRoute extends GoRouteData {
  SignupPageRoute();

  @override
  Widget build(context, state) => const SignupPage();
}

class SignupOtpPageRoute extends GoRouteData {
  SignupOtpPageRoute({
    required this.emailOrPhoneNumber,
  });
  final String emailOrPhoneNumber;

  @override
  Widget build(context, state) => OTPPage(
        emailOrPhoneNumber: emailOrPhoneNumber,
        from: SignupPageRoute().location,
      );
}


@TypedGoRoute<OnboardingQuestionPagesRoute>(
  name: 'onboardingQuestions',
  path: '/onboarding-questions',
)
class OnboardingQuestionPagesRoute extends GoRouteData {
  OnboardingQuestionPagesRoute();

  @override
  Widget build(context, state) => const OnboardingQuestionPages();
}

@TypedGoRoute<CubeAnimationPageRoute>(
  path: '/cube-animation',
  name: 'transisitionPage',
)
class CubeAnimationPageRoute extends GoRouteData {
  CubeAnimationPageRoute();

  @override
  Widget build(context, state) => const CubeAnimationPage();
}

//? ############ After Logged IN ################################

@TypedGoRoute<HomePageRoute>(
  name: 'home',
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SearchCoursesPageRoute>(
      path: 'searchCourses',
      name: 'searchCourses',
    ),
    TypedGoRoute<MyCoursesPageRoute>(
      name: 'myCourses',
      path: 'my-courses',
      routes: <TypedGoRoute<GoRouteData>>[],
    ),
    TypedGoRoute<ChooseSubjectPageRoute>(
      name: 'chooseSubject',
      path: 'choose-subject',
    ),
    TypedGoRoute<ExamsPageRoute>(
      name: 'examsPage',
      path: 'exams',
    ),
    TypedGoRoute<ChooseMockSubjectPageRoute>(
      name: 'mockSubject',
      path: 'mockSubject',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<UniversityMockExamPageRoute>(
          name: 'universityExamPage',
          path: 'university-exams',
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<UniversityMockExamDetailPage>(
              name: 'universityMockExamDetailPage',
              path: 'universityMockExamDetailPage',
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<UniversityMockExamsQuestionPageRoute>(
                  name: 'universityMockQuestionPage',
                  path: 'university-mock-question-page',
                  routes: <TypedGoRoute<GoRouteData>>[
                    TypedGoRoute<MocksChatWithApiRoute>(
                      name: 'mocksChatPage',
                      path: 'chat',
                    ),
                    TypedGoRoute<MockToContentPageRoute>(
                      path: 'content',
                      name: 'contentFromMock',
                    ),
                  ],
                ),
                TypedGoRoute<StandardMockResultPageRoute>(
                  name: 'standardMockResult',
                  path: 'standard-mock-result',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<MyExamsPageRoute>(
      name: 'myExamsPage',
      path: 'my-exams',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<MyExamsMockDetailPageRoute>(
            name: 'userMockExamDetailPage',
            path: 'userMockExamDetailPage',
            routes: <TypedGoRoute<GoRouteData>>[
              TypedGoRoute<MyExamsMockQuestionPageRoute>(
                name: 'userMockQuestionPage',
                path: 'userMockQuestionPage',
                routes: <TypedGoRoute<GoRouteData>>[
                  TypedGoRoute<UserMocksChatWithApiRoute>(
                    name: 'userMockChatPage',
                    path: 'userMockChat',
                  ),
                  TypedGoRoute<UserMockToContentPageRoute>(
                    path: 'userMockContent',
                    name: 'userMockContentFromMock',
                  ),
                ],
              ),
              TypedGoRoute<MyMockExamResultPageRoute>(
                name: 'myStandardMockResult',
                path: 'standard-mock-result',
              ),
            ]),
      ],
    ),
    TypedGoRoute<DownloadedMockExamsPageRoute>(
      name: 'downloadedMockExamsPage',
      path: 'downloadedMockExamsPage',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<DownloadedMockExamQuestionPageRoute>(
          name: 'downloadedMockExamQuestionPage',
          path: 'downloadedMockExamQuestionPage',
        ),
        TypedGoRoute<DownloadedMockResultPageRoute>(
          name: 'downloadedMockResultPage',
          path: 'downloadedMockResultPage',
        ),
      ],
    ),
    TypedGoRoute<UpdatedProfilePageRoute>(
      name: 'profile',
      path: 'profile',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<SettingsPageRoute>(path: 'settings', name: 'settings'),
        TypedGoRoute<EditProfilePageRoute>(
          path: 'editProfile',
        ),
        TypedGoRoute<CashoutPageRoute>(
          path: 'cashout',
          name: 'cashout',
        ),
        TypedGoRoute<FriendsMainPageRoute>(
          path: 'friends',
          name: 'friends',
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<AddFriendspageRoute>(
              path: 'addFriends',
              name: 'addFriends',
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<FriendsDetailFromAddFriendsPageRoute>(
                  path: 'freindsDetailFromAddFriends',
                  name: 'freindsDetailFromAddFriends',
                ),
              ],
            ),
            TypedGoRoute<FriendsDetailPageRoute>(
              path: 'freindsDetail',
              name: 'friendsdetail',
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<UserLeaderboardPageRoute>(
      name: 'leaderboard',
      path: 'leaderoard',
    ),
    TypedGoRoute<LeaderboardDetailPageRoute>(
      path: 'leaderboardDetail',
      name: 'leaderboardDetail',
    ),
    TypedGoRoute<BookmarkedContentPageRoute>(
      name: 'bookmarkedContent',
      path: 'bookmarkedContent',
    ),
    TypedGoRoute<BookmarkedQuestionPageRoute>(
      name: 'bookmarkedQuestion',
      path: 'bookmarkedQuestion',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<BookmarkedQuestionRelatedTopicPageRoute>(
          path: 'content/:courseId',
          name: 'bookmarkContent',
        ),
      ],
    ),
    TypedGoRoute<CourseDetailPageRoute>(
      name: 'courseDetail',
      path: 'course/:courseId',
      routes: <TypedRoute<GoRouteData>>[
        TypedGoRoute<EndOfChapterPageRoute>(
          path: 'endOfChapterPage',
          name: 'endOfChapterpage',
        ),
        TypedGoRoute<CreateQuizPageRoute>(
          name: 'createQuiz',
          path: 'quiz',
        ),
        TypedGoRoute<ContentPageRoute>(
          name: 'contentReadonly',
          path: 'content/:subChapterId',
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<ChatWithContentPageRoute>(
              name: 'chatWithContent',
              path: 'chat',
            ),
          ],
        ),
        TypedGoRoute<QuizQuestionPageRoute>(
          name: 'newQuizQuestionPage',
          path: 'quiz/:quizId',
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<QuizChatWithAIPageRoute>(
              path: 'chat/:questionId',
              name: 'chatWithAI',
            ),
            TypedGoRoute<QuizContentPageRoute>(
              path: 'content',
              name: 'contentFromQuiz',
            ),
          ],
        ),
        TypedGoRoute<QuizResultPageRoute>(
          name: 'quizResultPageRoute',
          path: 'quiz-result-page',
        ),
        TypedGoRoute<EndOfChapterQuestionsPageRoute>(
          name: 'endOfChapterQuestions',
          path: 'endOfChapterQuestions',
        ),
        TypedGoRoute<EndOfSubChapterQuestionsPageRoute>(
          path: 'endOfSubchapter',
          name: 'endOfSubchapter',
        ),
        TypedGoRoute<EndOfQuestionsResultPageRoute>(
          name: 'endOfQuestionsResult',
          path: 'endOfQuestionsResult',
        ),
        TypedGoRoute<ChannelVideosPageRoute>(
          name: 'channelVideos',
          path: 'channelVideos',
          // routes: <TypedGoRoute<GoRouteData>>[
          //   TypedGoRoute<VideoPlayerPageRoute>(
          //     name: 'videoPlayerPage',
          //     path: 'videoPlayerPage',
          //   ),
          // ],
        ),
        TypedGoRoute<VideoPlayerPageRoute>(
          name: 'videoPlayerPage',
          path: 'videoPlayerPage',
        ),
      ],
    ),
    TypedGoRoute<DownloadedCourseDetailPageRoute>(
      path: 'downloadedCourseDetailPage',
      name: 'downloadedCourseDetailPage',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<DownloadedContentPageRoute>(
          name: 'downloadedContentPage',
          path: 'downloadedContentPage/:chapterIdx/:subChapterIdx',
        ),
      ],
    ),
    // TypedGoRoute<MockQuestionPageRoute>(
    //   path: 'mockQuestionPage',
    //   name: 'mockQuestionPage',
    //   routes: <TypedGoRoute<GoRouteData>>[
    //     TypedGoRoute<MocksChatWithApiRoute>(
    //       name: 'mocksChatpage',
    //       path: 'chat',
    //     ),
    //     TypedGoRoute<MockToContentPageRoute>(
    //       path: 'content',
    //       name: 'contentFromMock',
    //     ),
    //   ],
    // ),
    TypedGoRoute<RecommendedMockResultPageRoute>(
      name: 'recommendedMockResult',
      path: 'recommended-mock-result',
    ),
    TypedGoRoute<CustomContestMainPageRoute>(
      name: 'customContestMainPage',
      path: 'customContestMainPage',
      routes: [
        TypedGoRoute<CustomContestCreatePageRoute>(
          name: 'customContestCreatePage',
          path: 'customContestCreatePage',
          routes: [],
        ),
        TypedGoRoute<CustomContestDetailPageRoute>(
          name: 'customContestDetailPage',
          path: 'customContestDetailPage/:customContestId',
          routes: [
            TypedGoRoute<CustomContestUpdatePageRoute>(
              name: 'customContestUpdatePage',
              path: 'customContestUpdatePage',
              routes: [],
            ),
            TypedGoRoute<CustomContestQuestionByCategoryPageRoute>(
              name: 'customContestQuestionByCategory',
              path: 'categoryQuestions',
              routes: [
                TypedGoRoute<CustomContestToContentPageRoute>(
                  name: 'customContestContent',
                  path: 'content',
                ),
                TypedGoRoute<CustomContestQuestionByCategoryChatWithAIPageRoute>(
                  name: 'customContestChatWithAI',
                  path: 'chat',
                ),
              ],
            ),
            TypedGoRoute<CustomContestInviteFriendsPageRoute>(
              name: 'customContestInviteFriendsPage',
              path: 'customContestInviteFriendsPage',
              routes: [
                TypedGoRoute<CustomContestAddFriendsPageRoute>(
                  name: 'customContestAddFriendsPage',
                  path: 'customContestAddFriendsPage',
                  routes: [],
                )
              ],
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<ContestDetailPageRoute>(
      name: 'contestDetail',
      path: 'contest/:id',
      routes: [
        TypedGoRoute<ContestQuestionByCategoryPageRoute>(
          name: 'contestQuestionByCategory',
          path: 'categoryQuestions',
          routes: [
            TypedGoRoute<ContestToContentPageRoute>(
              name: 'contestContent',
              path: 'content',
            ),
            TypedGoRoute<ContestQuestionByCategoryChatWithAIPageRoute>(
              name: 'contestChatWithAI',
              path: 'chat',
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<DailyQuizQuestionPageRoute>(
      name: 'dailyQuizQuestionPage',
      path: 'dailyQuiz',
      routes: [
        TypedGoRoute<DailyQuizContentPageRoute>(
          name: 'dailyQuizContent',
          path: 'content',
        ),
        TypedGoRoute<DailyQuizQuestionChatWithAIPageRoute>(
          name: 'dailyQuizChatWithAI',
          path: 'chat',
        ),
      ],
    ),
    TypedGoRoute<SharedQuestionPageRoute>(
      path: 'shared-question-page/:questionId',
      name: 'Shared Question Page',
    ),
    TypedGoRoute<NotificationsPageRoute>(
      path: 'notifications',
      name: 'Notifications page',
    ),
    TypedGoRoute<LearningPathPageRoute>(
      path: 'learningPathRoute',
    )
  ],
)
class HomePageRoute extends GoRouteData {
  HomePageRoute();
  // HomePageRoute({this.index});
  // final String? index;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // final index = int.tryParse(state.queryParameters['index'] ?? '') ?? 2;
    // return MyHomePage(index: index);
    return MyHomePage();
  }
}

class MyCoursesPageRoute extends GoRouteData {
  MyCoursesPageRoute();

  @override
  Widget build(context, state) => const MyCoursesPage(tabIndex: 0);
}

class ChooseSubjectPageRoute extends GoRouteData {
  ChooseSubjectPageRoute({
    this.$extra,
  });

  final bool? $extra;

  @override
  Widget build(context, state) => ChooseSubjectPage(
        forQuestionGeneration: $extra,
      );
}

class ExamsPageRoute extends GoRouteData {
  ExamsPageRoute();

  @override
  Widget build(context, state) => const ExamsPage();
}

class ChooseMockSubjectPageRoute extends GoRouteData {
  ChooseMockSubjectPageRoute({
    required this.isStandard,
  });
  final bool isStandard;

  @override
  Widget build(context, state) =>
      SelectSubjectForMockPage(isStandard: isStandard);
}

class UniversityMockExamPageRoute extends GoRouteData {
  UniversityMockExamPageRoute({
    required this.courseImage,
    required this.courseName,
    required this.isStandard,
  });

  final String courseImage;
  final String courseName;
  final bool isStandard;

  @override
  Widget build(context, state) => MockExamsPage(
        imageUrl: courseImage,
        courseName: courseName,
        isStandard: isStandard,
      );
}

class UniversityMockExamDetailPage extends GoRouteData {
  UniversityMockExamDetailPage({
    required this.courseImage,
    required this.courseName,
    required this.isStandard,
    required this.mockId,
  });

  final String courseImage;
  final String courseName;
  final bool isStandard;
  final String mockId;

  @override
  Widget build(context, state) => MockDetailPage(
        mockId: mockId,
        courseName: courseName,
        courseImage: courseImage,
        isStandard: isStandard,
      );
}

class UniversityMockExamsQuestionPageRoute extends GoRouteData {
  UniversityMockExamsQuestionPageRoute({
    required this.courseImage,
    required this.courseName,
    required this.isStandard,
    required this.mockId,
    required this.$extra,
  });

  final String courseImage;
  final String courseName;
  final bool isStandard;
  final String mockId;
  final MockExamQuestionPageParams $extra;

  @override
  Widget build(context, state) => MockExamQuestionsPage(
        mockExamQuestionPageParams: $extra,
      );
}

class StandardMockContentPageRoute extends GoRouteData {
  StandardMockContentPageRoute({
    required this.courseId,
    required this.mockId,
    required this.$extra,
    required this.courseImage,
    required this.courseName,
    required this.isStandard,
  });

  final String courseId;
  final String mockId;
  final QuestionMode $extra;
  final String courseImage;
  final String courseName;
  final bool isStandard;

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class StandardMockChatWithAIPageRoute extends GoRouteData {
  StandardMockChatWithAIPageRoute({
    required this.mockId,
    required this.questionId,
    required this.$extra,
    required this.courseImage,
    required this.courseName,
    required this.isStandard,
    required this.question,
  });

  final String mockId;
  final String questionId;
  final QuestionMode $extra;
  final String courseImage;
  final String courseName;
  final bool isStandard;
  final String question;

  @override
  Widget build(context, state) => ChatPage(
        questionId: questionId,
        isChatWithContent: false,
        question: question,
      );
}

class StandardMockResultPageRoute extends GoRouteData {
  StandardMockResultPageRoute({
    required this.$extra,
    required this.courseImage,
    required this.courseName,
    required this.isStandard,
  });

  final ResultPageParams $extra;
  final String courseImage;
  final String courseName;
  final bool isStandard;

  @override
  Widget build(context, state) => ResultPage(resultPageParams: $extra);
}

class MyExamsPageRoute extends GoRouteData {
  MyExamsPageRoute();

  @override
  Widget build(context, state) => const MyExamsPage();
}

class DownloadedMockExamsPageRoute extends GoRouteData {
  DownloadedMockExamsPageRoute();

  @override
  Widget build(context, state) => const DownloadedMocksPage();
}

class MyExamsMockDetailPageRoute extends GoRouteData {
  MyExamsMockDetailPageRoute({
    required this.mockId,
  });

  final String mockId;

  @override
  Widget build(context, state) => MockDetailPage(mockId: mockId);
}

class MyExamsMockQuestionPageRoute extends GoRouteData {
  MyExamsMockQuestionPageRoute({
    required this.mockId,
    required this.$extra,
  });

  final String mockId;
  final MockExamQuestionPageParams $extra;

  @override
  Widget build(context, state) => MockExamQuestionsPage(
        mockExamQuestionPageParams: $extra,
      );
}

class DownloadedMockExamQuestionPageRoute extends GoRouteData {
  DownloadedMockExamQuestionPageRoute({
    required this.$extra,
  });

  final DownloadedMockExamQuestionPageParams $extra;

  @override
  Widget build(context, state) => DownloadedMockExamQuestionsPage(
        mockExamQuestionPageParams: $extra,
      );
}

class MyMockExamContentPageRoute extends GoRouteData {
  MyMockExamContentPageRoute({
    required this.courseId,
    required this.mockId,
    required this.$extra,
    // required this.isStandard,
  });

  final String courseId;
  final String mockId;
  final QuestionMode $extra;
  // final bool isStandard;

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class MyMockExamChatWithAIPageRoute extends GoRouteData {
  MyMockExamChatWithAIPageRoute({
    required this.mockId,
    required this.questionId,
    required this.$extra,
    required this.isStandard,
    required this.question,
  });

  final String mockId;
  final String questionId;
  final QuestionMode $extra;
  final bool isStandard;
  final String question;

  @override
  Widget build(context, state) => ChatPage(
        questionId: questionId,
        isChatWithContent: false,
        question: question,
      );
}

class MyMockExamResultPageRoute extends GoRouteData {
  MyMockExamResultPageRoute({
    required this.$extra,
    required this.isStandard,
  });

  final ResultPageParams $extra;
  final bool isStandard;

  @override
  build(context, state) => ResultPage(resultPageParams: $extra);
}

class ProfilePageRoute extends GoRouteData {
  ProfilePageRoute();

  @override
  Widget build(context, state) => const ProfilePage();
}

class CourseDetailPageRoute extends GoRouteData {
  CourseDetailPageRoute({
    required this.courseId,
    this.lastStartedSubChapterId,
  });

  final String courseId;
  final String? lastStartedSubChapterId;

  @override
  Widget build(context, state) => CourseDetailPageNew(
        courseId: courseId,
        lastStartedSubChapterId: lastStartedSubChapterId,
      );
}

class DownloadedCourseDetailPageRoute extends GoRouteData {
  DownloadedCourseDetailPageRoute({
    required this.$extra,
  });

  final Course $extra;

  @override
  Widget build(context, state) => DownloadedCourseDetailPage(
        course: $extra,
      );
}

class CreateQuizPageRoute extends GoRouteData {
  CreateQuizPageRoute({required this.courseId});
  final String courseId;

  @override
  Widget build(context, state) => CreateQuizPage(courseId: courseId);
}

class ContentPageRoute extends GoRouteData {
  ContentPageRoute(
      {required this.courseId,
      required this.readOnly,
      required this.subChapterId});

  final String courseId;
  final bool readOnly;
  final String subChapterId;

  @override
  Widget build(context, state) => ContentPage(
        courseId: courseId,
        readOnly: readOnly,
        subChapterId: subChapterId,
      );
}

class DownloadedContentPageRoute extends GoRouteData {
  DownloadedContentPageRoute({
    required this.$extra,
    required this.chapterIdx,
    required this.subChapterIdx,
  });

  final Course $extra;
  final int chapterIdx;
  final int subChapterIdx;

  @override
  Widget build(context, state) => DownloadedContentPage(
        course: $extra,
        chapterIdx: chapterIdx,
        subChapterIdx: subChapterIdx,
      );
}

class ChatWithContentPageRoute extends GoRouteData {
  ChatWithContentPageRoute({
    required this.courseId,
    required this.subChapterId,
    required this.readOnly,
  });

  final String courseId;
  final String subChapterId;
  final bool readOnly;

  @override
  Widget build(context, state) => ChatPage(
        questionId: subChapterId,
        isChatWithContent: true,
      );
}

class BookmarkedContentPageRoute extends GoRouteData {
  final BookmarkedContent $extra;

  BookmarkedContentPageRoute({required this.$extra});
  @override
  Widget build(context, state) =>
      BookmarkedContentPage(bookmarkedContent: $extra);
}

class BookmarkedQuestionPageRoute extends GoRouteData {
  final BookmarkedQuestions $extra;

  BookmarkedQuestionPageRoute({required this.$extra});
  @override
  Widget build(context, state) =>
      QuestionBookmarkPage(bookmarkedQuestion: $extra);
}

class BookmarkedQuestionRelatedTopicPageRoute extends GoRouteData {
  final BookmarkedQuestions $extra;
  final String courseId;

  BookmarkedQuestionRelatedTopicPageRoute({
    required this.courseId,
    required this.$extra,
  });

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class QuizQuestionPageRoute extends GoRouteData {
  QuizQuestionPageRoute({
    required this.courseId,
    required this.quizId,
    required this.$extra,
  });

  final String courseId;
  final String quizId;
  final QuestionMode $extra;

  @override
  Widget build(context, state) => QuizExamQuestionPage(
        courseId: courseId,
        quizId: quizId,
        questionMode: $extra,
      );
}

class QuizContentPageRoute extends GoRouteData {
  QuizContentPageRoute({
    required this.courseId,
    required this.quizId,
    required this.$extra,
  });

  final String courseId;
  final String quizId;
  final QuestionMode $extra;

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class QuizChatWithAIPageRoute extends GoRouteData {
  QuizChatWithAIPageRoute({
    required this.courseId,
    required this.quizId,
    required this.questionId,
    required this.$extra,
    required this.question,
  });

  final String courseId;
  final String quizId;
  final String questionId;
  final String question;
  final QuestionMode $extra;

  @override
  Widget build(context, state) => ChatPage(
        questionId: questionId,
        isChatWithContent: false,
        question: question,
      );
}

class QuizResultPageRoute extends GoRouteData {
  QuizResultPageRoute({
    required this.courseId,
    required this.$extra,
  });

  final String courseId;
  final ResultPageParams $extra;

  @override
  Widget build(context, state) => ResultPage(resultPageParams: $extra);
}

class EndOfChapterQuestionsPageRoute extends GoRouteData {
  EndOfChapterQuestionsPageRoute({
    required this.courseId,
  });

  final String courseId;

  @override
  Widget build(context, state) => EndOfChapterQuestionsPage(
        chapterId: courseId,
        courseId: courseId,
      );
}

class EndOfSubChapterQuestionsPageRoute extends GoRouteData {
  EndOfSubChapterQuestionsPageRoute({
    required this.subTopicId,
    required this.courseId,
  });

  final String subTopicId;
  final String courseId;

  @override
  Widget build(context, state) => EndOfSubtopicQuestionsPage(
        subTopicId: subTopicId,
        courseId: courseId,
      );
}

class MockQuestionPageRoute extends GoRouteData {
  MockQuestionPageRoute({required this.$extra});

  final MockExamQuestionPageParams $extra;

  @override
  Widget build(context, state) => MockExamQuestionsPage(
        mockExamQuestionPageParams: $extra,
      );
}

class MockDetailPageRoute extends GoRouteData {
  MockDetailPageRoute({
    required this.mockId,
  });

  final String mockId;

  @override
  Widget build(context, state) => MockDetailPage(mockId: mockId);
}

class RecommendedMockContentPageRoute extends GoRouteData {
  RecommendedMockContentPageRoute({
    required this.courseId,
    required this.mockId,
    required this.$extra,
  });

  final String courseId;
  final String mockId;
  final QuestionMode $extra;

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class RecommendedMockChatWithAIPageRoute extends GoRouteData {
  RecommendedMockChatWithAIPageRoute({
    required this.mockId,
    required this.questionId,
    required this.$extra,
    required this.question,
  });

  final String mockId;
  final String questionId;
  final QuestionMode $extra;
  final String question;

  @override
  Widget build(context, state) => ChatPage(
        questionId: questionId,
        isChatWithContent: false,
        question: question,
      );
}

class MocksChatWithApiRoute extends GoRouteData {
  MocksChatWithApiRoute({
    required this.question,
    required this.questionId,
    required this.$extra,
    required this.isStandard,
    required this.courseImage,
    required this.courseName,
    required this.mockId,
  });

  final String questionId;
  final MockExamQuestionPageParams $extra;
  final String question;
  final bool isStandard;
  final String courseImage;
  final String courseName;
  final String mockId;

  @override
  Widget build(context, state) => ChatPage(
        questionId: questionId,
        isChatWithContent: false,
        question: question,
      );
}

class MockToContentPageRoute extends GoRouteData {
  MockToContentPageRoute({
    required this.courseId,
    required this.$extra,
    required this.isStandard,
    required this.courseImage,
    required this.courseName,
    required this.mockId,
  });

  final String courseId;
  final MockExamQuestionPageParams $extra;
  final bool isStandard;
  final String courseImage;
  final String courseName;
  final String mockId;

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class UserMocksChatWithApiRoute extends GoRouteData {
  UserMocksChatWithApiRoute({
    required this.question,
    required this.questionId,
    required this.mockId,
    required this.$extra,
  });

  final String questionId;
  final MockExamQuestionPageParams $extra;
  final String question;
  final String mockId;

  @override
  Widget build(context, state) => ChatPage(
        questionId: questionId,
        isChatWithContent: false,
        question: question,
      );
}

class UserMockToContentPageRoute extends GoRouteData {
  UserMockToContentPageRoute({
    required this.courseId,
    required this.$extra,
    required this.mockId,
  });

  final String courseId;
  final MockExamQuestionPageParams $extra;
  final String mockId;

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class RecommendedMockResultPageRoute extends GoRouteData {
  RecommendedMockResultPageRoute({required this.$extra});

  final ResultPageParams $extra;

  @override
  Widget build(context, state) => ResultPage(resultPageParams: $extra);
}

class DownloadedMockResultPageRoute extends GoRouteData {
  DownloadedMockResultPageRoute({required this.$extra});

  final ResultPageParams $extra;

  @override
  Widget build(context, state) => ResultPage(resultPageParams: $extra);
}

class EndOfQuestionsResultPageRoute extends GoRouteData {
  EndOfQuestionsResultPageRoute({required this.$extra, required this.courseId});

  final ResultPageParams $extra;
  final String courseId;

  @override
  Widget build(context, state) =>
      EndofQuestionsResultPage(resultPageParams: $extra);
}

class EndOfChapterPageRoute extends GoRouteData {
  EndOfChapterPageRoute({
    required this.courseId,
  });

  final String courseId;

  @override
  Widget build(context, state) => ContentFinalPage(
        courseId: courseId,
      );
}

class SearchCoursesPageRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SearchCoursePage();
}

class UserLeaderboardPageRoute extends GoRouteData {
  UserLeaderboardPageRoute();
  @override
  Widget build(context, state) => const UserLeaderboardPage();
}

class CustomContestMainPageRoute extends GoRouteData {
  CustomContestMainPageRoute();

  @override
  Widget build(context, state) => const CustomContestMainPage();
}

class CustomContestCreatePageRoute extends GoRouteData {
  CustomContestCreatePageRoute();

  @override
  Widget build(context, state) => const CustomContestCreatePage();
}

class CustomContestUpdatePageRoute extends GoRouteData {
  CustomContestUpdatePageRoute({
    required this.customContestId,
    this.$extra,
});

  final String customContestId;
  final CustomContestDetail? $extra;

  @override
  Widget build(context, state) => CustomContestCreatePage(customContestDetail: $extra,);
}

class CustomContestDetailPageRoute extends GoRouteData {
  CustomContestDetailPageRoute({
    required this.customContestId,
});

  final String customContestId;

  @override
  Widget build(context, state) => CustomContestDetailPage(
    customContestId: customContestId,
  );
}

class CustomContestQuestionByCategoryPageRoute extends GoRouteData {
  CustomContestQuestionByCategoryPageRoute({
    required this.customContestId,
    required this.$extra,
  });

  final String customContestId;
  final ContestQuestionByCategoryPageParams $extra;

  @override
  Widget build(context, state) => ContestQuestionsByCategoryPage(
    contestQuestionByCategoryPageparams:
    ContestQuestionByCategoryPageParams(
      categoryId: $extra.categoryId,
      timeLeft: $extra.timeLeft,
      customContestCategories: $extra.customContestCategories,
      contestId: $extra.contestId,
      updateSubmittedCategories: $extra.updateSubmittedCategories,
      hasEnded: $extra.hasEnded,
      isCustomContest: $extra.isCustomContest,
    ),
  );
}

class CustomContestInviteFriendsPageRoute extends GoRouteData {
  CustomContestInviteFriendsPageRoute({
    required this.customContestId,
  });

  final String customContestId;

  @override
  Widget build(context, state) => CustomContestInviteFriendsPage(
    customContestId: customContestId,
  );
}

class CustomContestAddFriendsPageRoute extends GoRouteData {
  CustomContestAddFriendsPageRoute({
    required this.customContestId,
  });

  final String customContestId;
  @override
  Widget build(context, state) => const AddFriendsPage();
}

class CustomContestToContentPageRoute extends GoRouteData {
  CustomContestToContentPageRoute({
    required this.customContestId,
    required this.courseId,
    required this.$extra,
  });

  final String customContestId;
  final String courseId;
  final ContestQuestionByCategoryPageParams $extra;


  @override
  Widget build(context, state) => RelatedTopicContentPage(
    courseId: courseId,
  );
}

class CustomContestQuestionByCategoryChatWithAIPageRoute extends GoRouteData {
  CustomContestQuestionByCategoryChatWithAIPageRoute({
    required this.customContestId,
  });

  final String customContestId;

  @override
  Widget build(context, state) => Container();
}

class ContestDetailPageRoute extends GoRouteData {
  ContestDetailPageRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(context, state) => ContestDetailPage(
        contestId: id,
      );
}

class ContestQuestionByCategoryPageRoute extends GoRouteData {
  final String id;
  final ContestQuestionByCategoryPageParams $extra;

  ContestQuestionByCategoryPageRoute({
    required this.id,
    required this.$extra,
  });

  @override
  Widget build(context, state) => ContestQuestionsByCategoryPage(
        contestQuestionByCategoryPageparams:
            ContestQuestionByCategoryPageParams(
          categoryId: $extra.categoryId,
          timeLeft: $extra.timeLeft,
          contestCategories: $extra.contestCategories,
          contestId: $extra.contestId,
          updateSubmittedCategories: $extra.updateSubmittedCategories,
          hasEnded: $extra.hasEnded,
        ),
      );
}

class ContestQuestionByCategoryChatWithAIPageRoute extends GoRouteData {
  ContestQuestionByCategoryChatWithAIPageRoute({
    required this.id,
    required this.questionId,
    required this.question,
    required this.$extra,
  });

  final String id;
  final String questionId;
  final String question;
  final ContestQuestionByCategoryPageParams $extra;

  @override
  Widget build(context, state) => ChatPage(
        isContest: true,
        questionId: questionId,
        question: question,
        isChatWithContent: false,
      );
}

class ContestToContentPageRoute extends GoRouteData {
  ContestToContentPageRoute({
    required this.id,
    required this.courseId,
    required this.$extra,
  });

  final String id;
  final String courseId;
  final ContestQuestionByCategoryPageParams $extra;

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class DailyQuizQuestionPageRoute extends GoRouteData {
  DailyQuizQuestionPageRoute({
    required this.$extra,
  });

  final DailyQuestionPageParams $extra;

  @override
  Widget build(context, state) => DailyQuestionPage(
        dailyQuestionPageParams: $extra,
      );
}

class DailyQuizQuestionChatWithAIPageRoute extends GoRouteData {
  DailyQuizQuestionChatWithAIPageRoute({
    required this.questionId,
    required this.question,
    required this.$extra,
  });

  final String questionId;
  final String question;
  final DailyQuestionPageParams $extra;

  @override
  Widget build(context, state) => ChatPage(
        questionId: questionId,
        question: question,
        isChatWithContent: false,
      );
}

class DailyQuizContentPageRoute extends GoRouteData {
  DailyQuizContentPageRoute({
    required this.$extra,
    required this.courseId,
  });

  final DailyQuestionPageParams $extra;
  final String courseId;

  @override
  Widget build(context, state) => RelatedTopicContentPage(
        courseId: courseId,
      );
}

class UpdatedProfilePageRoute extends GoRouteData {
  @override
  Widget build(context, state) => const UpdatedProfilePage();
}

class EditProfilePageRoute extends GoRouteData {
  @override
  Widget build(context, state) => const ProfileEditPage();
}

class LeaderboardDetailPageRoute extends GoRouteData {
  final String userId;

  LeaderboardDetailPageRoute({required this.userId});

  @override
  Widget build(context, state) => LeaderboardDetailPage(
        userId: userId,
      );
}

class FriendsDetailPageRoute extends GoRouteData {
  final String userId;

  FriendsDetailPageRoute({required this.userId});

  @override
  Widget build(context, state) => LeaderboardDetailPage(
        userId: userId,
      );
}

class FriendsDetailFromAddFriendsPageRoute extends GoRouteData {
  final String userId;

  FriendsDetailFromAddFriendsPageRoute({required this.userId});

  @override
  Widget build(context, state) => LeaderboardDetailPage(
        userId: userId,
      );
}

class VideoPlayerPageRoute extends GoRouteData {
  final String videoLink;
  final String courseId;
  final String? lastStartedSubChapterId;
  final List<SubchapterVideo> $extra;

  VideoPlayerPageRoute({
    required this.videoLink,
    required this.courseId,
    this.lastStartedSubChapterId,
    required this.$extra,
  });

  @override
  Widget build(context, state) => VideoPlayerPage(
        videoLink: videoLink,
        chatersVideos: $extra,
      );
}

class ChannelVideosPageRoute extends GoRouteData {
  final String channelId;
  final String courseId;
  final String channelName;
  final String channelDescritption;
  final int channelSubscribersCount;
  final String channelUrl;


  ChannelVideosPageRoute({
    required this.channelId,
    required this.courseId,
    required this.channelName,
    required this.channelDescritption,
    required this.channelSubscribersCount,
    required this.channelUrl
  });

  @override
  Widget build(context, state) => CourseChannelVideosPage(
        courseId: courseId,
        channelId: channelId,
        channelName: channelName,
        channelDescritption: channelDescritption,
        channelSubscribersCount:channelSubscribersCount,
        channelUrl: channelUrl,
      );
}

class SharedQuestionPageRoute extends GoRouteData {
  final String questionId;
  SharedQuestionPageRoute({required this.questionId});
  @override
  Widget build(context, state) => SharedQuestionPage(questionId: questionId);
}

class FriendsMainPageRoute extends GoRouteData {
  FriendsMainPageRoute();
  @override
  Widget build(context, state) => const FriendsMainPage();
}

class AddFriendspageRoute extends GoRouteData {
  AddFriendspageRoute();
  @override
  Widget build(context, state) => const AddFriendsPage();
}

class NotificationsPageRoute extends GoRouteData {
  NotificationsPageRoute();
  @override
  Widget build(context, state) => const NotificationPage();
}

class SettingsPageRoute extends GoRouteData {
  SettingsPageRoute();
  @override
  Widget build(context, state) => const SettingsPage();
}

class CashoutPageRoute extends GoRouteData {
  CashoutPageRoute();
  @override
  Widget build(context, state) => const CashoutPage();
}

class LearningPathPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LearningPathPage();
  }
}