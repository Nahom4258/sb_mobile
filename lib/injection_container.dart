import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:skill_bridge_mobile/core/bloc/home_page_nav/home_page_nav_bloc.dart';
import 'package:skill_bridge_mobile/core/bloc/localeBloc/locale_bloc.dart';
import 'package:skill_bridge_mobile/core/bloc/routerBloc/router_bloc.dart';
import 'package:skill_bridge_mobile/core/bloc/tokenSession/token_session_bloc.dart';
import 'package:skill_bridge_mobile/core/utils/hive_boxes.dart';
import 'package:skill_bridge_mobile/features/Notification/data/datasources/notifications_remotedatasource.dart';
import 'package:skill_bridge_mobile/features/Notification/data/repositories/notifications_repository_impl.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/repositories/notification_repositories.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/usecases/get_notifications_usecase.dart';
import 'package:skill_bridge_mobile/features/Notification/presentation/bloc/notification_bloc.dart';
import 'package:skill_bridge_mobile/features/bookmarks/domain/usecases/bookmark_question_usecase.dart';
import 'package:skill_bridge_mobile/features/bookmarks/domain/usecases/delete_bookmarked_content.dart';
import 'package:skill_bridge_mobile/features/bookmarks/domain/usecases/delete_bookmarked_question_usecase.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/bloc/addContentBookmarkBloc/add_content_bookmark_bloc_bloc.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/bloc/bookmarksBoc/bookmarks_bloc_bloc.dart';
import 'package:skill_bridge_mobile/features/bookmarks/presentation/bloc/deleteContentBookmark/delete_content_bookmark_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/domain/usecases/contest_ranking_usercase.dart';
import 'package:skill_bridge_mobile/features/contest/domain/usecases/fetch_contest_questions_by_category_usecase.dart';
import 'package:skill_bridge_mobile/features/contest/domain/usecases/get_contest_detail_usecase.dart';
import 'package:skill_bridge_mobile/features/contest/domain/usecases/regster_to_contest.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/fetch_contest_question_by_category/fetch_contest_questions_by_category_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/contest_ranking_bloc/contest_ranking_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/fetch_custom_contest_ranking/fetch_custom_contest_ranking_bloc.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/bloc/registerContest/register_contest_bloc.dart';
import 'package:skill_bridge_mobile/features/course/data/datasources/courses_local_data_sources.dart';
import 'package:skill_bridge_mobile/features/course/domain/usecases/get_video_channels.dart';
import 'package:skill_bridge_mobile/features/course/domain/usecases/update_video_status_usecase.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/changeVideoStatus/change_video_status_bloc.dart';
import 'package:skill_bridge_mobile/features/course/presentation/bloc/getVideoChannelsCubit/get_video_channels_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/data/datasources/friends_remote_datasource.dart';
import 'package:skill_bridge_mobile/features/friends/data/repositories/friends_repository_impl.dart';
import 'package:skill_bridge_mobile/features/friends/domain/repositories/freinds_repository.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/accept_or_reject_friend_request_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/get_all_friends_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/get_recived_requests_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/get_sent_requests_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/recieve_friend_request_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/search_friends_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/send_friend_request_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/withdraw_friend_request_usecase%20copy.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/acceptOrRejectCubit/accept_or_reject_friend_reques_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/withdrawRequestCubit/withdraw_friend_request_cubit.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/allFriendsBloc/friends_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/getRecivedRequestsBloc/get_recived_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/getSentRequestsBloc/get_sent_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/reciveFriendRequest/recieve_friend_request_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/searchFriendsBloc/search_friends_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/sendFriendRequestBloc/send_friend_request_bloc.dart';
import 'package:skill_bridge_mobile/features/home/domain/usecases/show_refresh_token_popup_usecase.dart';
import 'package:skill_bridge_mobile/features/onboarding/domain/usecases/get_schools_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/cashout_requests_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/change_user_avatar_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/get_school_info_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/get_top_users_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/get_user_consistancy_data.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/get_user_refferal_info_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/load_chart_categories_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/barChartBloc/bar_chart_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/cashoutRequestsBloc/cashout_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/consistancyBloc/consistancy_bloc_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/deleteAccountBloc/delete_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/externalUsersBloc/external_userProfile_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/schoolInfoBloc/school_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/topThreeUsersLeaderboardBloc/users_leaderboard_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userRefferalInfoCubit/user_refferal_info_cubit.dart';
import 'package:skill_bridge_mobile/features/question/domain/usecases/general_chat_usecase.dart';
import 'package:skill_bridge_mobile/features/question/domain/usecases/get_end_chapter_questions_usecase.dart';
import 'package:skill_bridge_mobile/features/question/domain/usecases/get_question_by_id_usecase.dart';
import 'package:skill_bridge_mobile/features/question/presentation/bloc/bloc/general_chat_bloc.dart';
import 'package:skill_bridge_mobile/features/question/presentation/bloc/endOfChaptersQuestionsBloc/endof_chapter_questions_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/change_password_usercase.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/change_username_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changePasswordBloc/password_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changeUsernameBloc/username_bloc.dart';
import 'package:skill_bridge_mobile/features/question/presentation/bloc/singleQuestionBloc/single_question_bloc.dart';
import 'package:skill_bridge_mobile/features/onboarding/presentation/bloc/schools_bloc/schols_bloc.dart' as schools_bloc;

import 'features/bookmarks/data/data.dart';
import 'features/bookmarks/domain/domain.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_bloc.dart';
import 'features/bookmarks/presentation/bloc/addQuestionBookmarkBloc/add_question_bookmark_bloc.dart';
import 'features/bookmarks/presentation/bloc/deleteQuestionBookmarkBloc/delete_question_bookmark_bloc.dart';
import 'features/course/presentation/bloc/course/course_bloc.dart';
import 'features/profile/presentation/bloc/logout/logout_bloc.dart';

import 'core/core.dart';
import 'features/features.dart';
import 'features/profile/presentation/bloc/usersLeaderboard/users_leaderboard_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features
  //! Feature_#1 Authentication ----------------------------

  // Bloc
  serviceLocator.registerFactory(
    () => AuthenticationBloc(
      signupUsecase: serviceLocator(),
      loginUsecase: serviceLocator(),
      logoutUsecase: serviceLocator(),
      forgetPasswordUsecase: serviceLocator(),
      changePasswordUsecase: serviceLocator(),
      initializeAppUsecase: serviceLocator(),
      getAppInitializationUsecase: serviceLocator(),
      resendOtpVerificationUsecase: serviceLocator(),
      sendOtpVerificationUsecase: serviceLocator(),
      signInWithGoogleUsecase: serviceLocator(),
      signOutWithGoogleUsecase: serviceLocator(),
      getSignInWithGoogleUsecase: serviceLocator(),
      getSignInWithAppleUsecase: serviceLocator(),
      signInWithAppleUsecase: serviceLocator(),
      signOutWithAppleUsecase: serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
    () => SignupFormBloc(),
  );
    
  serviceLocator.registerFactory(
    () => ChangePasswordFormBloc(),
  );
  serviceLocator.registerFactory(
    () => GetUserBloc(
      getUserCredentialUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => StoreDeviceTokenBloc(
      storeDeviceTokenUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => DeleteDeviceTokenBloc(deleteDeviceTokenUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(() => schools_bloc.SchoolBloc(getSchoolsUseCase: serviceLocator()));

  // Usecase
  serviceLocator
      .registerLazySingleton(() => SignupUsecase(repository: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => LoginUsecase(repository: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => LogoutUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ForgetPasswordUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ChangePasswordUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SendOtpVerificationUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ResendOtpVerificationUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => InitializeAppUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetAppInitializationUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetUserCredentialUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SignInWithGoogleUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SignOutWithGoogleUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetSignInWithGoogleUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => StoreDeviceTokenUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => DeleteDeviceTokenUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SignInWithAppleUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SignOutWithAppleUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetSignInWithAppleUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetSchools(repository: serviceLocator()));
  // Repository
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      remoteDatasource: serviceLocator(),
      localDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // DataSource
  serviceLocator.registerLazySingleton<AuthenticationLocalDatasource>(
    () => AuthenticationLocalDatasourceImpl(
      flutterSecureStorage: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<AuthenticationRemoteDatasource>(
    () => AuthenticationRemoteDatasourceImpl(
      client: serviceLocator(),
    ),
  );

  //! Feature_#2 Home ----------------------------------------

  // Bloc
  serviceLocator.registerFactory(
    () => HomeBloc(
      getMyCoursesUsecase: serviceLocator(),
      getHomeUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetExamDateBloc(
      getExamDateUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FetchDailyStreakBloc(
      fetchDailyStreakUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FetchDailyQuizBloc(
      fetchDailyQuizUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FetchDailyQuizForAnalysisBloc(
      fetchDailyQuizForAnalysisUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SubmitDailyQuizAnswerBloc(
      submitDailyQuizAnswerUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FetchDailyQuestBloc(
      fetchDailyQuestUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ShowRefreshTokenPopupBloc(
      showRefreshTokenPopupUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => HomePageNavBloc(),
  );

  // Usecase
  serviceLocator.registerLazySingleton(
    () => GetMyCoursesUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetExamDateUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetHomeUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => FetchDailyStreakUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => FetchDailyQuizUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => FetchDailyQuizForAnalysisUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SubmitDailyQuizAnswerUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => FetchDailyQuestUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ShowRefreshTokenPopupUsecase(
      homeRepository: serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
        localDatasource: serviceLocator(),
        remoteDatasource: serviceLocator(),
        networkInfo: serviceLocator(),
        flutterSecureStorage: serviceLocator()),
  );

  // Datasource
  serviceLocator.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(
      flutterSecureStorage: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(
        client: serviceLocator(),
        flutterSecureStorage: serviceLocator(),
        homeLocalDatasource: serviceLocator()),
  );

  //! Feature_#3 Department -------------------------------

  // bloc
  serviceLocator.registerFactory(
    () => DepartmentBloc(
      getAllGeneralDepartmentUsecase: serviceLocator(),
    ),
  );

  // usecase
  serviceLocator.registerLazySingleton(
    () => GetAllGeneralDepartmentUsecase(
      repository: serviceLocator(),
    ),
  );

  // repository
  serviceLocator.registerLazySingleton<DepartmentRepository>(
    () => DepartmentRepositoryImpl(
      remoteDatasource: serviceLocator(),
      localDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // datasource
  serviceLocator.registerLazySingleton<DepartmentRemoteDatasource>(
    () => DepartmentRemoteDatasourceImpl(
      client: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DepartmentLocalDatasource>(
    () => DepartmentLocaDatasourceImpl(),
  );

  //! Feature_#4 CourseDetail and Option ---------------------

  // Bloc
  serviceLocator.registerFactory(
    () => CourseWithUserAnalysisBloc(
      getCourseUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SelectCourseBloc(
      getCoursesByDepartmentIdUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<DepartmentCourseBloc>(
    () => DepartmentCourseBloc(
      getDepartmentCourseUsecase: serviceLocator(),
    ),
  );
  // serviceLocator.registerFactory(
  //   () => CourseBloc(),
  // );
  serviceLocator.registerFactory(
    () => ChatWithContentBloc(
      chatUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<CourseBloc>(
    CourseBloc(),
  );
  serviceLocator.registerFactory<FetchCourseVideosBloc>(
    () => FetchCourseVideosBloc(
      fetchCourseVideosUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<ChangeVideoStatusBloc>(
    () => ChangeVideoStatusBloc(
      updateVideoStatusUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OfflineCourseBloc>(
    () => OfflineCourseBloc(
      downloadCourseByIdUsecase: serviceLocator(),
      fetchDownloadedCoursesUsecase: serviceLocator(),
      isCourseDownloadedUsecase: serviceLocator(),
      markCourseAsDownloadedUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<GetVideoChannelsCubit>(
    () => GetVideoChannelsCubit(
      getVideoChannelsUsecase: serviceLocator(),
    ),
  );

  // Usecase
  serviceLocator.registerLazySingleton(
    () => GetCourseWithAnalysisUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetCoursesByDepartmentIdUseCase(
      courseRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetDepartmentCourseUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ChatWithContentUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => FetchCourseVideosUsecase(
      courseRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateVideoStatusUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DownloadCourseByIdUsecase(
      courseRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => FetchDownloadedCoursesUsecase(
      courseRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => IsCourseDownloadedUsecase(
      courseRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => MarkCourseAsDownloadedUsecase(
      courseRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetVideoChannelsUsecase(
      courseRepositories: serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerLazySingleton<CourseRepositories>(
    () => CourseRepositoryImpl(
        networkInfo: serviceLocator(),
        remoteDataSource: serviceLocator(),
        coursesLocalDatasource: serviceLocator(),
        flutterSecureStorage: serviceLocator()),
  );

  // Datasource
  serviceLocator.registerLazySingleton<CourseRemoteDataSource>(
    () => CourseRemoteDataSourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
      coursesLocalDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<CoursesLocalDatasource>(
      () => CoursesLocalDatasourceImpl());

  //! Feature_#5 UserCourses
  //bloc
  //! Feature 4 UserCourses ------------------------
  serviceLocator.registerFactory(
    () => UserCoursesBloc(
      userCoursesUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SelectDepartmentBloc(
      getAllGeneralDepartmentUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => RegisterCourseBloc(registerCourseUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () =>
        SubChapterRegstrationBloc(registerSubChapterUsecase: serviceLocator()),
  );
  // Usecase
  serviceLocator.registerLazySingleton(
    () => UserCoursesUseCase(courseRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => RegisterSubChapterUsecase(courseRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => RegisterCourseUsecase(courseRepositories: serviceLocator()),
  );

  //! Feature_#6 Search

  // Bloc
  serviceLocator.registerFactory(
    () => SearchCourseBloc(
      searchCoursesUsecase: serviceLocator(),
    ),
  );

  // Usecase
  serviceLocator.registerLazySingleton(
    () => SearchCoursesUsecase(
      serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
    ),
  );

  // Datasource
  serviceLocator.registerLazySingleton<SearchCourseRemoteDataSource>(
    () => SearchCourseRemoteDataSourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
    ),
  );

  //! Feature_#6 Mock Exam

  // Bloc
  serviceLocator.registerFactory(
    () => MockExamBloc(
      getDepartmentMocksUsecase: serviceLocator(),
      getMockExamsUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => MyMocksBloc(
      getMyMocksUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => MockQuestionBloc(
      getMockExamByIdUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserMockBloc(
      addMockToUserMocksUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UpsertMockScoreBloc(
      upsertMockScoreUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => RetakeMockBloc(
      retakeMockUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GeneralChatBloc(
      generalChatUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => MockDetailBloc(
      getMockDetailUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OfflineMockBloc>(
    () => OfflineMockBloc(
      downloadMockByIdUsecase: serviceLocator(),
      fetchDownloadedMocksUsecase: serviceLocator(),
      isMockDownloadedUsecase: serviceLocator(),
      markMockAsDownloadedUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OfflineMockUserAnswerBloc>(
    () => OfflineMockUserAnswerBloc(
      upsertOfflineMockUserAnswerUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OfflineMockUserScoreBloc>(
    () => OfflineMockUserScoreBloc(
      upsertOfflineMockScoreUsecase: serviceLocator(),
    ),
  );

  // Usecase
  serviceLocator.registerLazySingleton(
    () => GetMockExamsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetMockExamByIdUsecase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetDepartmentMocksUsecase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UpsertMockScoreUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetMyMocksUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AddMockToUserMocksUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => RetakeMockUsecase(
      mockExamRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GeneralChatUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetMockDetailUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DownloadMockByIdUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => FetchDownloadedMocksUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => IsMockDownloadedUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => MarkMockAsDownloadedUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UpsertOfflineMockUserAnswerUsecase(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UpsertOfflineMockScoreUsecase(
      repository: serviceLocator(),
    ),
  );

  // repository
  serviceLocator.registerLazySingleton<MockExamRepository>(
    () => MockExamRepositoryImpl(
      remoteDatasource: serviceLocator(),
      localDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // datasource
  serviceLocator.registerLazySingleton<MockExamLocalDatasource>(
    () => MockExamLocalDatasourceImpl(),
  );
  serviceLocator.registerLazySingleton<MockExamRemoteDatasource>(
    () => MockExamRemoteDatasourceImpl(
      localDataSource: serviceLocator(),
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
    ),
  );

  //! Feature #7 - Question

  // Bloc
  serviceLocator.registerFactory(
    () => QuestionBloc(
      submitUserAnswerUsecase: serviceLocator(),
      getEndSubtopicQuestionUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => EndofChapterQuestionsBloc(
        getEndOfChapterQuestionsUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => PopupMenuBloc(),
  );
  serviceLocator.registerFactory(
    () => SingleQuestionBloc(
      getQuestionByIdUsecase: serviceLocator(),
    ),
  );

  // Usecases
  serviceLocator.registerLazySingleton(
    () => SubmitUserAnswerUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetEndOfChapterQuestionsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetEndSubtopicQuestionUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQuestionByIdUsecase(
      repository: serviceLocator(),
    ),
  );
  // Repository
  serviceLocator.registerLazySingleton<QuestionRepository>(
    () => QuestionRepositoryImpl(
      localDatasource: serviceLocator(),
      remoteDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // Datasource
  serviceLocator.registerLazySingleton<QuestionLocalDatasource>(
    () => QuestionLocalDatasourceImpl(),
  );
  serviceLocator.registerLazySingleton<QuestionRemoteDatasource>(
    () => QuestionRemoteDatasourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
    ),
  );

  //! Feature 8 Chapter------------------------------

  serviceLocator.registerFactory(
    () => ChapterBloc(
      getSubchaptersListUsecase: serviceLocator(),
      getChapterByCourseIdUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SubChapterBloc(getContentOfSubChapterUsecase: serviceLocator()),
  );
  // Usecase
  serviceLocator.registerLazySingleton(
    () => GetContentOfSubChapterUsecase(chapterRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetSubChaptersListUsecase(chapterRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetChapterByCourseIdUsecase(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<ChapterRepository>(
    () => ChapterRepositoryImpl(
      networkInfo: serviceLocator(),
      chapterRemoteDatasource: serviceLocator(),
    ),
  );

  // Datasource
  serviceLocator.registerLazySingleton<ChapterRemoteDatasource>(
    () => ChapterRemoteDataSourceImpl(
      flutterSecureStorage: serviceLocator(),
      client: serviceLocator(),
    ),
  );

  //! Feature 9 Quiz

  // Bloc
  serviceLocator.registerFactory(
    () => QuizBloc(
      getUserQuizUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => QuizCreateBloc(
      createQuizUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => QuizQuestionBloc(
      getQuizByIdUsecase: serviceLocator(),
      saveQuizScoreUsecase: serviceLocator(),
    ),
  );

  // Usecase
  serviceLocator.registerLazySingleton(
    () => GetUserQuizUsecase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => CreateQuizUsecase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetQuizByIdUsecase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => SaveQuizScoreUsecase(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // Datasource
  serviceLocator.registerLazySingleton<QuizRemoteDataSource>(
    () => QuizRemoteDataSourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
      localDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<QuizLocalDatasource>(
    () => QuizLocalDatasourceImpl(),
  );
  // Datasource
  serviceLocator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      flutterSecureStorage: serviceLocator(),
      profileLocalDataSource: serviceLocator(),
      client: serviceLocator(),
    ),
  );

  //! Feature 10 Proifle
  serviceLocator.registerFactory(
    () => TopThreeUsersBloc(
      getTopUsersUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserRefferalInfoCubit(
      getUserRefferalInfoUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LogoutBloc(
      logoutUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => DeleteAccountBloc(profileDeleteAccountUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ExternalUsersBloc(
      getProfileUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SchoolBloc(
      getSchoolInfoUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UsersLeaderboardBloc(getTopUsersUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ConsistancyBlocBloc(getUserConsistencyDataUsecase: serviceLocator()),
  );
  // Usecase
  serviceLocator.registerLazySingleton(
    () => ProfileLogoutUsecase(profileRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => ProfileDeleteAccountUsecase(profileRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetUserRefferalInfoUsecase(profileRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetSchoolInfoUsecase(profileRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetTopUsersUsecase(profileRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetUserConsistencyDataUsecase(profileRepositories: serviceLocator()),
  );
  // Repository
  serviceLocator.registerLazySingleton<ProfileRepositories>(
    () => ProfileRepositoryImpl(
      profileLocalDataSource: serviceLocator(),
      profileRemoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
      hiveBoxes: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(flutterSecureStorage: serviceLocator()),
  );

  //! Feature 11 Chat
  // bloc
  serviceLocator.registerFactory(
    () => ChatBloc(
      chatUsecase: serviceLocator(),
    ),
  );

  // usecase
  serviceLocator.registerLazySingleton(() => ChatUsecase(
        repository: serviceLocator(),
      ));
  //! Feature 11 Feedback
  serviceLocator.registerFactory(
    () => FeedbackBloc(
      submitContentFeedbackUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => QuestionVoteBloc(
      voteQuestionUsecase: serviceLocator(),
    ),
  );

  // Usecase
  serviceLocator.registerLazySingleton(
    () => SubmitContentFeedbackUsecase(feedbackRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => VoteQuestionUsecase(
      feedbackRepositories: serviceLocator(),
    ),
  );
  // Repository
  serviceLocator.registerLazySingleton<FeedbackRepositories>(
    () => FeedbackRepositoriesImpl(
      feedbackRemoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<FeedbackRemoteDataSource>(
    () => FeedbackRemoteDataSourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
    ),
  );

  //! Feature 12 Onboarding
  //bloc
  serviceLocator.registerFactory(
    () => OnboardingBloc(submitOnbardingQuestionsUsecase: serviceLocator()),
  );
  //usecase
  serviceLocator.registerLazySingleton(
    () => SubmitOnbardingQuestionsUsecase(
        onboardingQuestionsRepository: serviceLocator()),
  );
  //repository
  serviceLocator.registerLazySingleton<OnboardingQuestionsRepository>(
    () => OnboardingQuestionsRepositoryImpl(
      authLocalDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
      remoteDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<OnboardingQuestionsRemoteDataSource>(
    () => OnboardingQuestionsRemoteDataSourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
    ),
  );

  //! feature 13 bookmarking
  //bloc
  serviceLocator.registerFactory(
    () => BookmarksBlocBloc(getUserBookmarksUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => DeleteContentBookmarkBloc(
        deleteContentBookmarkUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => AddContentBookmarkBlocBloc(contentBookmarkUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
      () => AddQuestionBookmarkBloc(questionBookmarkUsecase: serviceLocator()));
  serviceLocator.registerFactory(() => DeleteQuestionBookmarkBloc(
      deleteQuestionBookmarkUsecase: serviceLocator()));
  //usecase
  serviceLocator.registerLazySingleton(
    () => GetUserBookmarksUsecase(bookmarkRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteContentBookmarkUsecase(bookmarkRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => ContentBookmarkUsecase(bookmarkRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteQuestionBookmarkUsecase(bookmarkRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => QuestionBookmarkUsecase(bookmarkRepositories: serviceLocator()),
  );
  //repository
  serviceLocator.registerLazySingleton<BookmarkRepositories>(
    () => BookmarksReposirotyImpl(
      bookmarksRemoteDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BookmarksRemoteDatasource>(
      () => BookmarksRemoteDatasourceImpl(
            client: serviceLocator(),
            flutterSecureStorage: serviceLocator(),
          ));

  //? feature 13 profile page
  //bloc
  serviceLocator.registerFactory(
    () => UserProfileBloc(getProfileUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => BarChartBloc(
      getBarChartDataUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CashoutRequestsBloc(
      cashoutRequestsUsecase: serviceLocator(),
    ),
  );
  //usecase
  serviceLocator.registerLazySingleton(
    () => GetProfileUsecase(profileRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetBarChartDataUseCase(profileRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => CashoutRequestsUsecase(profileRepositories: serviceLocator()),
  );
  //! Feature Contest
  // Bloc
  serviceLocator.registerFactory(
    () => FetchPreviousContestsBloc(fetchAllContestsUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => FetchPreviousUserContestsBloc(
        fetchUserContestsUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => FetchContestByIdBloc(fetchContestByIdUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => FetchUpcomingUserContestBloc(
        fetchUpcomingUserContestUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ContestDetailBloc(getContestDetailUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => FetchContestQuestionsByCategoryBloc(
        fetchContestQuestionsByCategoryUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => RegisterContestBloc(contestRegstrationUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ContestRankingBloc(getContestRankingUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ContestSubmitUserAnswerBloc(
        contestSubmitUserAnswerUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => FetchContestAnalysisByCategoryBloc(
        fetchContestAnalysisByCategoryUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => FetchLiveContestBloc(
          fetchLiveContestsUsecase: serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
    () => LiveContestBloc(
      cacheLiveContestUsecase: serviceLocator(),
      clearLiveContestUsecase: serviceLocator(),
      getLiveContestUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchPreviousCustomContestBloc(
      fetchPreviousCustomContestsUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => CreateCustomContestBloc(
          createCustomContestUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchCustomContestSubjectsBloc(
          fetchCustomContestSubjectsUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchUpcomingCustomContestBloc(
      fetchUpcomingCustomContestsUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchCustomContestDetailBloc(
      fetchCustomContestDetailUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => UpdateCustomContestBloc(
      updateCustomContestUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchCustomContestQuestionsByCategoryBloc(
      fetchCustomContestQuestionsByCategoryUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchCustomContestInvitationsBloc(
      fetchCustomContestInvitationsUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => RegisterToCustomContestInvitesBloc(
      registerToCustomContestInvitesUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchCustomContestAnalysisByCategoryBloc(
      fetchCustomContestAnalysisByCategoryUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchRegisteredFriendsForCustomContestBloc(
      fetchRegisteredFriendsUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => SendInvitesForCustomContestBloc(
      sendInvitesForCustomContestUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchCustomContestRankingBloc(
      fetchCustomContestRankingUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => DeleteCustomContestByIdBloc(
      deleteCustomContestByIdUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchFriendsBloc(
      fetchFriendsUsecase: serviceLocator(),
    ),
  );

  // Usecase
  serviceLocator.registerLazySingleton(
    () => FetchPreviousContestsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => FetchPreviousUserContestsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => FetchContestByIdUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetContestDetailUsecase(contestRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => ContestRegstrationUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => FetchUpcomingUserContestUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetContestRankingUsecase(contestRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => FetchContestQuestionsByCategoryUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => SubmitContestUserAnswerUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => FetchContestAnalysisByCategoryUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchLiveContestsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => CacheLiveContestUsecase(contestRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => ClearLiveContestUsecase(contestRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetLiveContestUsecase(contestRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchPreviousCustomContestsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => CreateCustomContestUsecase(contestRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchCustomContestSubjectsUsecase(contestRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchUpcomingCustomContestsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchCustomContestDetailUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => UpdateCustomContestUsecase(contestRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchCustomContestQuestionsByCategoryUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchCustomContestInvitationsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => RegisterToCustomContestInvitesUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchCustomContestAnalysisByCategoryUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchRegisteredFriendsUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => SendInvitesForCustomContestUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchCustomContestRankingUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => DeleteCustomContestByIdUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
        () => FetchFriendsUsecase(repository: serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<ContestRepository>(
    () => ContestRepositoryImpl(
      remoteDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
      localDatasource: serviceLocator(),
    ),
  );

  // Datasource
  serviceLocator.registerLazySingleton<ContestRemoteDatasource>(
    () => ContestRemoteDatasourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
      contestLocalDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ContestLocalDatasource>(
    () => ContestLocalDatasourceImpl(),
  );

  //! Feature AlertDialog
  serviceLocator.registerFactory(
    () => AlertDialogBloc(),
  );

  // feature 16 Change Password and Change Username
  //bloc
  serviceLocator.registerFactory(
    () => UsernameBloc(
        changeUsernameUsecase: serviceLocator(),
        updateProfileusecase: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => PasswordBloc(changePasswordusecase: serviceLocator()),
  );

  //usecase
  serviceLocator.registerLazySingleton(
    () => ChangeUsernameUsecase(profileRepositories: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => ChangePasswordusecase(profileRepositories: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateUserProfileUsecase(profileRepositories: serviceLocator()),
  );

  //? friends

  // blocs
  serviceLocator.registerFactory(
    () => FriendsBloc(getAllFriendsUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => SearchFriendsBloc(searchFriendsUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetSentRequestsBloc(getSentRequestsUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetRecivedRequestsBloc(getRecivedRequestsUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => SendFriendRequestBloc(sendFriendRequestUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () =>
        RecieveFriendRequestBloc(recieveFriendRequestUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => WithdrawFriendRequestCubit(
        withdrawFriendRequestUsecase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => AcceptOrRejectFriendRequesCubit(
        acceptOrRejectFriendRequestUsecase: serviceLocator()),
  );
  // use cases
  serviceLocator.registerLazySingleton(
    () => GetAllFriendsUsecase(friendsRepo: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => SearchFriendsUsecase(friendsRepo: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetSentRequestsUsecase(friendsRepo: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetRecivedRequestsUsecase(friendsRepo: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => SendFriendRequestUsecase(friendsRepo: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => RecieveFriendRequestUsecase(friendsRepo: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => WithdrawFriendRequestUsecase(friendsRepo: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => AcceptOrRejectFriendRequestUsecase(friendsRepo: serviceLocator()),
  );
  // Repository
  serviceLocator.registerLazySingleton<FriendsRepositories>(
    () => FriendsRepositoryImpl(
      friendsRemoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // Datasource
  serviceLocator.registerLazySingleton<FriendsRemoteDataSource>(
    () => FriendsRemoteDataSourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
    ),
  );

  //! Notifications
  //
  // Bloc
  serviceLocator.registerFactory(() => NotificationBloc(
        getNotificationsUsecase: serviceLocator(),
      ));

  // Use cases
  serviceLocator.registerLazySingleton(() => GetNotificationsUsecase(
        repositories: serviceLocator(),
      ));

  // Repository
  serviceLocator.registerLazySingleton<NotificationRepositories>(
    () => NotificationsRepositoryImpl(
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
    ),
  );

  // Datasource
  serviceLocator.registerLazySingleton<NotificationsRemotedatasource>(
    () => NotificationsRemotedatasourceImpl(
      client: serviceLocator(),
      flutterSecureStorage: serviceLocator(),
    ),
  ); // //repository
  // serviceLocator.registerLazySingleton<ChangeUsernameRepositories>(
  //   () => ChangeUsernameRepositoriesImpl(
  //     networkInfo: serviceLocator(),
  //     changeUsernameRemoteDataSource: serviceLocator(),
  //     profileLocalDataSource: serviceLocator(),

  //   ),
  // );

  // serviceLocator.registerLazySingleton<ChangePasswordRepositories>(
  //   () => ChangePasswordRepositoriesImpl(
  //     networkInfo: serviceLocator(),
  //     changePasswordRemoteDataSource: serviceLocator(),
  //   ),
  // );

  // // Datasource
  // serviceLocator.registerLazySingleton<ChangeUsernameRemoteDataSource>(
  //   () => ChangeUsernameRemoteDataSourceImpl(
  //     client: serviceLocator(),
  //     flutterSecureStorage: serviceLocator(),
  //   ),
  // );

  // serviceLocator.registerLazySingleton<ChangePasswordRemoteDataSource>(
  //   () => ChangePasswordRemoteDataSourceImpl(
  //     client: serviceLocator(),
  //     flutterSecureStorage: serviceLocator(),
  //   ),
  // );
  serviceLocator.registerFactory(() => RouterBloc());
  serviceLocator.registerFactory(
    () => LocaleBloc(
      flutterSecureStorage: serviceLocator(),
    ),
  );

  //! Core ----------------------------------
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        internetConnectionChecker: serviceLocator(),
      ));

  serviceLocator.registerFactory(() => TokenSessionBloc());
  //! External-----------------------------------
  const flutterSecureStorage = FlutterSecureStorage();
  final hiveBoxes = HiveBoxes();
  serviceLocator.registerFactory(() => flutterSecureStorage);
  serviceLocator.registerFactory(() => hiveBoxes);

  final client = InterceptedClient.build(
    retryPolicy: ExpiredTokenRetryPolicy(),
    interceptors: [],
    client: http.Client(),
  );
  serviceLocator.registerLazySingleton(() => client);
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
