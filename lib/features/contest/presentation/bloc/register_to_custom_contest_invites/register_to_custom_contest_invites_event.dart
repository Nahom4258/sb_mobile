part of 'register_to_custom_contest_invites_bloc.dart';

class RegisterToCustomContestInvitesEvent extends Equatable {
  const RegisterToCustomContestInvitesEvent({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
