part of 'send_invites_for_custom_contest_bloc.dart';

class SendInvitesForCustomContestState extends Equatable {
  const SendInvitesForCustomContestState();

  @override
  List<Object?> get props => [];
}

class SendInvitesForCustomContestInitial extends SendInvitesForCustomContestState {}
class SendInvitesForCustomContestLoading extends SendInvitesForCustomContestState {}
class SendInvitesForCustomContestLoaded extends SendInvitesForCustomContestState {}
class SendInvitesForCustomContestFailed extends SendInvitesForCustomContestState {
  const SendInvitesForCustomContestFailed({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
