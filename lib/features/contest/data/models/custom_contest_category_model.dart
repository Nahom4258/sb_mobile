import '../../../features.dart';

class CustomContestCategoryModel extends CustomContestCategory {
  const CustomContestCategoryModel({
    required super.id,
    required super.customContestId,
    required super.subject,
    required super.numberOfQuestions,
    required super.userScore,
    required super.isSubmitted,
  });

  factory CustomContestCategoryModel.fromJson(Map<String, dynamic> json) {
    return CustomContestCategoryModel(
      id: json['_id'] ?? '',
      customContestId: json['customContestId'] ?? '',
      subject: json['subject'] ?? '',
      numberOfQuestions: json['numOfQuestions'] ?? 0,
      userScore: json['userScore'] ?? 0,
      isSubmitted: json['isSubmitted'] ?? false,
    );
  }
}