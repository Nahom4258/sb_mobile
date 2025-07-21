import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_profile_entity_get.dart';

abstract class ExternalUserProfileState extends Equatable {
  const ExternalUserProfileState();

  @override
  List<Object> get props => [];

  get userProfile => null;
}

class ProfileEmpty extends ExternalUserProfileState {}

class ExternalUserProfileLoaded extends ExternalUserProfileState {
  @override
  final UserProfile userProfile;

  const ExternalUserProfileLoaded({required this.userProfile});
  @override
  List<Object> get props => [userProfile];
}

class ExternalUserProfileLoading extends ExternalUserProfileState {}

class ExternalUserProfileFailedState extends ExternalUserProfileState {
  final String errorMessage;
  final Failure? failure;

  const ExternalUserProfileFailedState(
      {required this.errorMessage, this.failure});
}
