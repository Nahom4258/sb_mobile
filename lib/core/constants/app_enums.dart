enum FeedbackType { questionFeedback, contentFeedback }

enum QuestionMode { learning, quiz, analysis, none }

enum ExamType {
  quiz,
  standardMock,
  aiGeneratedMock,
  endOfChapterQuestions,
  downloadedMock
}

enum MockType {
  recommendedMocks,
  standardMocks,
  myStandardMocks,
  myAIGeneratedMocks,
  bookmarkedQuestion,
  downloadedMock,
}

enum LeaderboardType {
  all_alltime,
  all_weekly,
  all_monthly,
  friends_alltime,
  friends_weekly,
  friends_monthly,
  school_alltime,
  school_weekly,
  school_monthly,
}

// notificatin types
enum NotificationTypes {
  friendRequest,
  accepterdFriendRequest,
  invitedContest,
  registeredContest,
  contestWinner,
  contestProgress,
  studyReminder,
  general,
  customeContestInvite,
  customeContestRegistered,
  weeklyProgressReport
}
