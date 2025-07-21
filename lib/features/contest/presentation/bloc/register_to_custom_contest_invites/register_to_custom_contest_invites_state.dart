part of 'register_to_custom_contest_invites_bloc.dart';

class RegisterToCustomContestInvitesState extends Equatable {
  const RegisterToCustomContestInvitesState();

  @override
  List<Object?> get props => [];
}

class RegisterToCustomContestInvitesInitial extends RegisterToCustomContestInvitesState {}

class RegisterToCustomContestInvitesLoading extends RegisterToCustomContestInvitesState {
  const RegisterToCustomContestInvitesLoading({required this.customContestId});

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}

class RegisterToCustomContestInvitesLoaded extends RegisterToCustomContestInvitesState {
  const RegisterToCustomContestInvitesLoaded({required this.customContestId});
  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}

class RegisterToCustomContestInvitesFailed extends RegisterToCustomContestInvitesState {
  const RegisterToCustomContestInvitesFailed({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

