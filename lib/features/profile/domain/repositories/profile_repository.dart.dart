import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/constants/app_enums.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/all_barchart_categories_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/consistency_entity.dart';

import 'package:skill_bridge_mobile/features/profile/domain/entities/profile_update_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/school_info_enitity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_cashout_requests_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_refferal_info_entity.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/usersLeaderboard/users_leaderboard_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../features.dart';
import '../entities/user_leaderboard_entity.dart';

abstract class ProfileRepositories {
  Future<Either<Failure, UserProfile>> getUserProfile(
      {required bool isRefreshed, String? userId});
  Future<Either<Failure, ChangeUsernameEntity>> postChangeUsername(
      String firstname, String lastname);
  Future<Either<Failure, ChangePasswordEntity>> postChangePassword(
      String oldPassword, String newPassword, String repeatPassword);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> deleteAccount();
  Future<Either<Failure, void>> updateProfile(ProfileUpdateEntity updateEntity);
  Future<Either<Failure, Leaderboard>> getTopUsers({
    required int page,
    required LeaderboardType leaderboardtype,
    required bool isForTopThree,
  });
  Future<Either<Failure, List<ConsistencyEntity>>> getUserConsistencyData(
      {required String year, String? userId});

  Future<Either<Failure, SchoolDepartmentInfo>> getSchoolInfo();
  Future<Either<Failure, ScoreCategoryListEntity>> getBarChartData();
  Future<Either<Failure, UserRefferalInfoEntity>> getUserRefferalInfo();
  Future<Either<Failure, UserCashoutRequestsEntity>> getUserCashoutRequests();
}
