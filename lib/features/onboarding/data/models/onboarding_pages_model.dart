import '../../domain/entities/onboarding_questions_response.dart';

class OnboardingQuestionsModel extends OnboardingQuestionsResponse {
  const OnboardingQuestionsModel({
    super.howPrepared,
    super.preferedMethod,
    super.studyTimePerday,
    super.motivation,
    required super.id,
    required super.challengingSubjects,
    super.reminderTime,
    super.gender,
    required super.school,
    required super.region,
    required super.grade,
  });
  // factory OnboardingQuestionsModel.fromJson(Map<String, dynamic> json) {
  //   return OnboardingQuestionsModel(
  //     id: json['_id'],
  //     userId: json['userId'],
  //     course: CourseModel.fromUserCourseJson(json['course']),
  //     completedChapters: json['completedChapters'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'howPrepared': howPrepared,
      'preferredMetho': preferedMethod,
      'studyTimePerDa': studyTimePerday,
      'motivation': motivation,
      'department': id,
      'challengingSubjects': challengingSubjects,
      'reminder': reminderTime.toString(),
      'highSchool': school,
      'region': region,
      'gender': gender,
      'grade': grade.toString()
    };
  }
}
