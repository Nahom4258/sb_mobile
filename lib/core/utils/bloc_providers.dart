import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_bridge_mobile/core/bloc/alert_dialog/alert_dialog_bloc.dart';
import 'package:skill_bridge_mobile/core/bloc/home_page_nav/home_page_nav_bloc.dart';
import 'package:skill_bridge_mobile/core/bloc/localeBloc/locale_bloc.dart';
import 'package:skill_bridge_mobile/core/bloc/routerBloc/router_bloc.dart';
import 'package:skill_bridge_mobile/core/bloc/tokenSession/token_session_bloc.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/bloc/notification_bloc.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/bloc/addContentBookmarkBloc/add_content_bookmark_bloc_bloc.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/bloc/addQuestionBookmarkBloc/add_question_bookmark_bloc.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/bloc/bookmarksBoc/bookmarks_bloc_bloc.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/bloc/deleteContentBookmark/delete_content_bookmark_bloc.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/bloc/deleteQuestionBookmarkBloc/delete_question_bookmark_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/contest_ranking_bloc/contest_ranking_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/fetch_custom_contest_ranking/fetch_custom_contest_ranking_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/registerContest/register_contest_bloc.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/changeVideoStatus/change_video_status_bloc.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/course/course_bloc.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/getVideoChannelsCubit/get_video_channels_cubit.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/playerPageCubit/video_player_page_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/acceptOrRejectCubit/accept_or_reject_friend_reques_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/withdrawRequestCubit/withdraw_friend_request_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/allFriendsBloc/friends_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/getRecivedRequestsBloc/get_recived_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/getSentRequestsBloc/get_sent_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/reciveFriendRequest/recieve_friend_request_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/searchFriendsBloc/search_friends_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/sendFriendRequestBloc/send_friend_request_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/barChartBloc/bar_chart_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/cashoutRequestsBloc/cashout_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changePasswordBloc/password_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changeUsernameBloc/username_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/consistancyBloc/consistancy_bloc_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/deleteAccountBloc/delete_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/externalUsersBloc/external_userProfile_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/logout/logout_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/schoolInfoBloc/school_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/topThreeUsersLeaderboardBloc/users_leaderboard_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userRefferalInfoCubit/user_refferal_info_cubit.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/usersLeaderboard/users_leaderboard_bloc.dart';
import 'package:skill_bridge_mobile/features/question/presentation/bloc/bloc/general_chat_bloc.dart';
import 'package:skill_bridge_mobile/features/question/presentation/bloc/endOfChaptersQuestionsBloc/endof_chapter_questions_bloc.dart';
import 'package:skill_bridge_mobile/features/question/presentation/bloc/singleQuestionBloc/single_question_bloc.dart';
import 'package:skill_bridge_mobile/injection_container.dart';
import 'package:skill_bridge_mobile/features/onboarding/presentation/bloc/schools_bloc/schols_bloc.dart'
    as onboarding_school_bloc;
import '../../features/features.dart';

List<BlocProvider> registedBlocs() {
  return [
    BlocProvider<TokenSessionBloc>(
      create: (_) => serviceLocator<TokenSessionBloc>(),
    ),
    BlocProvider<AuthenticationBloc>(
      create: (_) => serviceLocator<AuthenticationBloc>(),
    ),
    BlocProvider<SignupFormBloc>(
      create: (_) => serviceLocator<SignupFormBloc>(),
    ),
    BlocProvider<ChangePasswordFormBloc>(
      create: (_) => serviceLocator<ChangePasswordFormBloc>(),
    ),
    BlocProvider<GetUserBloc>(
      create: (_) => serviceLocator<GetUserBloc>(),
    ),
    BlocProvider<HomeBloc>(
      create: (_) => serviceLocator<HomeBloc>(),
    ),
    BlocProvider<GetExamDateBloc>(
      create: (_) => serviceLocator<GetExamDateBloc>(),
    ),
    BlocProvider<DepartmentBloc>(
      create: (_) => serviceLocator<DepartmentBloc>(),
    ),
    BlocProvider<UserCoursesBloc>(
      create: (_) => serviceLocator<UserCoursesBloc>(),
    ),
    BlocProvider<SelectDepartmentBloc>(
      create: (_) => serviceLocator<SelectDepartmentBloc>(),
    ),
    BlocProvider<CourseWithUserAnalysisBloc>(
      create: (_) => serviceLocator<CourseWithUserAnalysisBloc>(),
    ),
    BlocProvider<SelectCourseBloc>(
      create: (_) => serviceLocator<SelectCourseBloc>(),
    ),
    BlocProvider<CourseBloc>(
      create: (_) => serviceLocator<CourseBloc>(),
    ),
    BlocProvider<ChatWithContentBloc>(
      create: (_) => serviceLocator<ChatWithContentBloc>(),
    ),
    BlocProvider<DepartmentCourseBloc>(
      create: (_) => serviceLocator<DepartmentCourseBloc>(),
    ),
    BlocProvider<SelectCourseBloc>(
      create: (_) => serviceLocator<SelectCourseBloc>(),
    ),
    BlocProvider<SearchCourseBloc>(
      create: (_) => serviceLocator<SearchCourseBloc>(),
    ),
    BlocProvider<MockExamBloc>(
      create: (_) => serviceLocator<MockExamBloc>(),
    ),
    BlocProvider<MyMocksBloc>(
      create: (_) => serviceLocator<MyMocksBloc>(),
    ),
    BlocProvider<MockQuestionBloc>(
      create: (_) => serviceLocator<MockQuestionBloc>(),
    ),
    BlocProvider<UserMockBloc>(
      create: (_) => serviceLocator<UserMockBloc>(),
    ),
    BlocProvider<UpsertMockScoreBloc>(
      create: (_) => serviceLocator<UpsertMockScoreBloc>(),
    ),
    BlocProvider<ChapterBloc>(
      create: (_) => serviceLocator<ChapterBloc>(),
    ),
    BlocProvider<SubChapterBloc>(
      create: (_) => serviceLocator<SubChapterBloc>(),
    ),
    BlocProvider<QuestionBloc>(
      create: (_) => serviceLocator<QuestionBloc>(),
    ),
    BlocProvider<PopupMenuBloc>(
      create: (_) => serviceLocator<PopupMenuBloc>(),
    ),
    BlocProvider<QuizBloc>(
      create: (_) => serviceLocator<QuizBloc>(),
    ),
    BlocProvider<QuizCreateBloc>(
      create: (_) => serviceLocator<QuizCreateBloc>(),
    ),
    BlocProvider<QuizQuestionBloc>(
      create: (_) => serviceLocator<QuizQuestionBloc>(),
    ),
    BlocProvider<RegisterCourseBloc>(
      create: (_) => serviceLocator<RegisterCourseBloc>(),
    ),
    BlocProvider<LogoutBloc>(create: (_) => serviceLocator<LogoutBloc>()),
    BlocProvider<DeleteAccountBloc>(create: (_) => serviceLocator<DeleteAccountBloc>()),
    BlocProvider<SubChapterRegstrationBloc>(
      create: (_) => serviceLocator<SubChapterRegstrationBloc>(),
    ),
    BlocProvider<ChatBloc>(
      create: (_) => serviceLocator<ChatBloc>(),
    ),
    BlocProvider<FeedbackBloc>(
      create: (_) => serviceLocator<FeedbackBloc>(),
    ),
    BlocProvider<QuestionVoteBloc>(
      create: (_) => serviceLocator<QuestionVoteBloc>(),
    ),
    BlocProvider<OnboardingBloc>(
      create: (_) => serviceLocator<OnboardingBloc>(),
    ),
    BlocProvider<BookmarksBlocBloc>(
      create: (_) => serviceLocator<BookmarksBlocBloc>(),
    ),
    BlocProvider<AddContentBookmarkBlocBloc>(
      create: (_) => serviceLocator<AddContentBookmarkBlocBloc>(),
    ),
    BlocProvider<DeleteContentBookmarkBloc>(
      create: (_) => serviceLocator<DeleteContentBookmarkBloc>(),
    ),
    BlocProvider<AlertDialogBloc>(
      create: (_) => serviceLocator<AlertDialogBloc>(),
    ),
    BlocProvider<UserProfileBloc>(
      create: (_) => serviceLocator<UserProfileBloc>(),
    ),
    BlocProvider<AddQuestionBookmarkBloc>(
      create: (_) => serviceLocator<AddQuestionBookmarkBloc>(),
    ),
    BlocProvider<DeleteQuestionBookmarkBloc>(
      create: (_) => serviceLocator<DeleteQuestionBookmarkBloc>(),
    ),
    BlocProvider<EndofChapterQuestionsBloc>(
      create: (_) => serviceLocator<EndofChapterQuestionsBloc>(),
    ),
    BlocProvider<UsernameBloc>(
      create: (_) => serviceLocator<UsernameBloc>(),
    ),
    BlocProvider<PasswordBloc>(
      create: (_) => serviceLocator<PasswordBloc>(),
    ),
    BlocProvider<UsersLeaderboardBloc>(
      create: (_) => serviceLocator<UsersLeaderboardBloc>(),
    ),
    BlocProvider<TopThreeUsersBloc>(
      create: (_) => serviceLocator<TopThreeUsersBloc>(),
    ),
    BlocProvider<StoreDeviceTokenBloc>(
      create: (_) => serviceLocator<StoreDeviceTokenBloc>(),
    ),
    BlocProvider<DeleteDeviceTokenBloc>(
      create: (_) => serviceLocator<DeleteDeviceTokenBloc>(),
    ),
    BlocProvider<FetchPreviousContestsBloc>(
      create: (_) => serviceLocator<FetchPreviousContestsBloc>(),
    ),
    BlocProvider<FetchPreviousUserContestsBloc>(
      create: (_) => serviceLocator<FetchPreviousUserContestsBloc>(),
    ),
    BlocProvider<FetchContestByIdBloc>(
      create: (_) => serviceLocator<FetchContestByIdBloc>(),
    ),
    BlocProvider<FetchUpcomingUserContestBloc>(
      create: (_) => serviceLocator<FetchUpcomingUserContestBloc>(),
    ),
    BlocProvider<ContestDetailBloc>(
      create: (_) => serviceLocator<ContestDetailBloc>(),
    ),
    BlocProvider<RegisterContestBloc>(
      create: (_) => serviceLocator<RegisterContestBloc>(),
    ),
    BlocProvider<ContestRankingBloc>(
      create: (_) => serviceLocator<ContestRankingBloc>(),
    ),
    BlocProvider<FetchContestQuestionsByCategoryBloc>(
      create: (_) => serviceLocator<FetchContestQuestionsByCategoryBloc>(),
    ),
    BlocProvider<ContestSubmitUserAnswerBloc>(
      create: (_) => serviceLocator<ContestSubmitUserAnswerBloc>(),
    ),
    BlocProvider<FetchDailyStreakBloc>(
      create: (_) => serviceLocator<FetchDailyStreakBloc>(),
    ),
    BlocProvider<FetchDailyQuizBloc>(
      create: (_) => serviceLocator<FetchDailyQuizBloc>(),
    ),
    BlocProvider<FetchDailyQuizForAnalysisBloc>(
      create: (_) => serviceLocator<FetchDailyQuizForAnalysisBloc>(),
    ),
    BlocProvider<SubmitDailyQuizAnswerBloc>(
      create: (_) => serviceLocator<SubmitDailyQuizAnswerBloc>(),
    ),
    BlocProvider<ConsistancyBlocBloc>(
      create: (_) => serviceLocator<ConsistancyBlocBloc>(),
    ),
    BlocProvider<FetchDailyQuestBloc>(
      create: (_) => serviceLocator<FetchDailyQuestBloc>(),
    ),
    BlocProvider<SchoolBloc>(
      create: (_) => serviceLocator<SchoolBloc>(),
    ),
    BlocProvider<FetchContestAnalysisByCategoryBloc>(
      create: (_) => serviceLocator<FetchContestAnalysisByCategoryBloc>(),
    ),
    BlocProvider<RetakeMockBloc>(
      create: (_) => serviceLocator<RetakeMockBloc>(),
    ),
    BlocProvider<FetchCourseVideosBloc>(
      create: (_) => serviceLocator<FetchCourseVideosBloc>(),
    ),
    BlocProvider<RouterBloc>(
      create: (_) => serviceLocator<RouterBloc>(),
    ),
    BlocProvider<LocaleBloc>(
      create: (_) => serviceLocator<LocaleBloc>(),
    ),
    BlocProvider<GeneralChatBloc>(
      create: (_) => serviceLocator<GeneralChatBloc>(),
    ),
    BlocProvider<MockDetailBloc>(
      create: (_) => serviceLocator<MockDetailBloc>(),
    ),
    BlocProvider<SingleQuestionBloc>(
      create: (_) => serviceLocator<SingleQuestionBloc>(),
    ),
    BlocProvider<ChangeVideoStatusBloc>(
      create: (_) => serviceLocator<ChangeVideoStatusBloc>(),
    ),
    BlocProvider<OfflineCourseBloc>(
      create: (_) => serviceLocator<OfflineCourseBloc>(),
    ),
    BlocProvider<OfflineMockBloc>(
      create: (_) => serviceLocator<OfflineMockBloc>(),
    ),
    BlocProvider<OfflineMockUserAnswerBloc>(
      create: (_) => serviceLocator<OfflineMockUserAnswerBloc>(),
    ),
    BlocProvider<OfflineMockUserScoreBloc>(
      create: (_) => serviceLocator<OfflineMockUserScoreBloc>(),
    ),
    BlocProvider<BarChartBloc>(
      create: (_) => serviceLocator<BarChartBloc>(),
    ),
    BlocProvider<FriendsBloc>(
      create: (_) => serviceLocator<FriendsBloc>(),
    ),
    BlocProvider<SearchFriendsBloc>(
      create: (_) => serviceLocator<SearchFriendsBloc>(),
    ),
    BlocProvider<GetSentRequestsBloc>(
      create: (_) => serviceLocator<GetSentRequestsBloc>(),
    ),
    BlocProvider<GetRecivedRequestsBloc>(
      create: (_) => serviceLocator<GetRecivedRequestsBloc>(),
    ),
    BlocProvider<SendFriendRequestBloc>(
      create: (_) => serviceLocator<SendFriendRequestBloc>(),
    ),
    BlocProvider<RecieveFriendRequestBloc>(
      create: (_) => serviceLocator<RecieveFriendRequestBloc>(),
    ),
    BlocProvider<WithdrawFriendRequestCubit>(
      create: (_) => serviceLocator<WithdrawFriendRequestCubit>(),
    ),
    BlocProvider<AcceptOrRejectFriendRequesCubit>(
      create: (_) => serviceLocator<AcceptOrRejectFriendRequesCubit>(),
    ),
    BlocProvider<ExternalUsersBloc>(
      create: (_) => serviceLocator<ExternalUsersBloc>(),
    ),
    BlocProvider<GetVideoChannelsCubit>(
      create: (_) => serviceLocator<GetVideoChannelsCubit>(),
    ),
    BlocProvider<UserRefferalInfoCubit>(
      create: (_) => serviceLocator<UserRefferalInfoCubit>(),
    ),
    BlocProvider<NotificationBloc>(
      create: (_) => serviceLocator<NotificationBloc>(),
    ),
    BlocProvider<CashoutRequestsBloc>(
      create: (_) => serviceLocator<CashoutRequestsBloc>(),
    ),
    BlocProvider<VideoPlayerPageCubit>(create: (_) => VideoPlayerPageCubit()),
    BlocProvider<LiveContestBloc>(
      create: (_) => serviceLocator<LiveContestBloc>(),
    ),
    BlocProvider<FetchLiveContestBloc>(
      create: (_) => serviceLocator<FetchLiveContestBloc>(),
    ),
    BlocProvider<FetchPreviousCustomContestBloc>(
      create: (_) => serviceLocator<FetchPreviousCustomContestBloc>(),
    ),
    BlocProvider<CreateCustomContestBloc>(
      create: (_) => serviceLocator<CreateCustomContestBloc>(),
    ),
    BlocProvider<FetchCustomContestSubjectsBloc>(
      create: (_) => serviceLocator<FetchCustomContestSubjectsBloc>(),
    ),
    BlocProvider<FetchUpcomingCustomContestBloc>(
      create: (_) => serviceLocator<FetchUpcomingCustomContestBloc>(),
    ),
    BlocProvider<FetchCustomContestDetailBloc>(
      create: (_) => serviceLocator<FetchCustomContestDetailBloc>(),
    ),
    BlocProvider<UpdateCustomContestBloc>(
      create: (_) => serviceLocator<UpdateCustomContestBloc>(),
    ),
    BlocProvider<FetchCustomContestQuestionsByCategoryBloc>(
      create: (_) => serviceLocator<FetchCustomContestQuestionsByCategoryBloc>(),
    ),
    BlocProvider<FetchCustomContestInvitationsBloc>(
      create: (_) => serviceLocator<FetchCustomContestInvitationsBloc>(),
    ),
    BlocProvider<RegisterToCustomContestInvitesBloc>(
      create: (_) => serviceLocator<RegisterToCustomContestInvitesBloc>(),
    ),
    BlocProvider<FetchCustomContestAnalysisByCategoryBloc>(
      create: (_) => serviceLocator<FetchCustomContestAnalysisByCategoryBloc>(),
    ),
    BlocProvider<FetchRegisteredFriendsForCustomContestBloc>(
      create: (_) => serviceLocator<FetchRegisteredFriendsForCustomContestBloc>(),
    ),
    BlocProvider<SendInvitesForCustomContestBloc>(
      create: (_) => serviceLocator<SendInvitesForCustomContestBloc>(),
    ),
    BlocProvider<FetchCustomContestRankingBloc>(
      create: (_) => serviceLocator<FetchCustomContestRankingBloc>(),
    ),
    BlocProvider<DeleteCustomContestByIdBloc>(
      create: (_) => serviceLocator<DeleteCustomContestByIdBloc>(),
    ),
    BlocProvider<FetchFriendsBloc>(
      create: (_) => serviceLocator<FetchFriendsBloc>(),
    ),
    BlocProvider<onboarding_school_bloc.SchoolBloc>(
        create: (_) => serviceLocator<onboarding_school_bloc.SchoolBloc>()),
    BlocProvider<HomePageNavBloc>(
      create: (_) => serviceLocator<HomePageNavBloc>(),
    ),
    BlocProvider<ShowRefreshTokenPopupBloc>(
        create: (_) => serviceLocator<ShowRefreshTokenPopupBloc>()),
  ];
}
