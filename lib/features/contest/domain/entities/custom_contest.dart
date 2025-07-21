import 'package:equatable/equatable.dart';

class CustomContest extends Equatable {
  final String id;
  final String title;
  final bool isLive;
  final DateTime startsAt;
  final DateTime endsAt;
  final int userScore;

  const CustomContest({required this.id, required this.title, required this.isLive, required this.startsAt, required this.endsAt, required this.userScore});


  @override
  List<Object?> get props => [id, title, isLive, startsAt, endsAt, userScore];

}