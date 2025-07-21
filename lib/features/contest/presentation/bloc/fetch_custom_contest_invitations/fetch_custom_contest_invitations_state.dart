part of 'fetch_custom_contest_invitations_bloc.dart';

class FetchCustomContestInvitationsState extends Equatable {
  const FetchCustomContestInvitationsState();

  @override
  List<Object?> get props => [];
}

class FetchCustomContestInvitationsInitial extends FetchCustomContestInvitationsState {}

class FetchCustomContestInvitationsLoading extends FetchCustomContestInvitationsState {}

class FetchCustomContestInvitationsLoaded extends FetchCustomContestInvitationsState {
  const FetchCustomContestInvitationsLoaded({required this.customContestInvitations});

  final List<CustomContest> customContestInvitations;

  @override
  List<Object?> get props => [customContestInvitations];
}

class FetchCustomContestInvitationsFailed extends FetchCustomContestInvitationsState {
  const FetchCustomContestInvitationsFailed({required this.failure});

  final Failure failure;
  @override
  List<Object?> get props => [failure];
}
