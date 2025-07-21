import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../features.dart';

class CustomContestDetail extends Equatable {

  const CustomContestDetail({
    required this.customContestId,
    required this.title,
    required this.description,
    required this.isUpcoming,
    required this.hasRegistered,
    required this.hasEnded,
    required this.contestType,
    required this.userScore,
    required this.timeLeft,
    required this.startsAt,
    required this.endsAt,
    required this.isLive,
    required this.userRank,
    required this.isOwner,
    required this.customContestCategories,
  });

  final String customContestId;
  final String title;
  final String description;
  final bool isUpcoming;
  final bool hasRegistered;
  final bool hasEnded;
  final String contestType;
  final int userScore;
  final double timeLeft;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool isLive;
  final int userRank;
  final bool isOwner;
  final List<CustomContestCategory> customContestCategories;



  @override
  List<Object?> get props => [customContestId, title, description, isUpcoming, timeLeft, hasRegistered, hasEnded, contestType, userScore, startsAt, endsAt, isLive, userRank, isOwner, customContestCategories,];

}

