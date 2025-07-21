import 'package:equatable/equatable.dart';

import '../../../features.dart';

class HomeEntity extends Equatable {
  final HomeChapter? lastStartedChapter;
  final List<ExamDate> examDates;
  final List<HomeMock> homeMocks;
  final num coin;
  final num refferalCount;
  final int rank;
  final int tottalUserCount;
  final int totalUnseenNotifications;
  const HomeEntity({
    required this.lastStartedChapter,
    required this.examDates,
    required this.homeMocks,
    required this.coin,
    required this.rank,
    required this.refferalCount,
    required this.tottalUserCount,
    required this.totalUnseenNotifications,
  });

  @override
  List<Object?> get props => [lastStartedChapter, examDates, homeMocks];
}
