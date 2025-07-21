import 'package:equatable/equatable.dart';

class CustomContestCategory extends Equatable {

  const CustomContestCategory({
    required this.id,
    required this.customContestId,
    required this.subject,
    required this.numberOfQuestions,
    required this.userScore,
    required this.isSubmitted,
  });

  final String id;
  final String customContestId;
  final String subject;
  final int numberOfQuestions;
  final int userScore;
  final bool isSubmitted;


  @override
  List<Object?> get props => [id, customContestId, subject, numberOfQuestions, userScore, isSubmitted];
}