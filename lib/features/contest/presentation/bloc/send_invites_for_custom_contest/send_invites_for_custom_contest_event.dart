part of 'send_invites_for_custom_contest_bloc.dart';

class SendInvitesForCustomContestEvent extends Equatable {
  const SendInvitesForCustomContestEvent({
    required this.contestId,
    required this.friendsList,
  });

  final String contestId;
  final List<String> friendsList;

  @override
  List<Object?> get props => [contestId, friendsList];
}
