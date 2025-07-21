import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';

import '../../../../../core/core.dart';

part 'send_invites_for_custom_contest_event.dart';
part 'send_invites_for_custom_contest_state.dart';

class SendInvitesForCustomContestBloc extends Bloc<SendInvitesForCustomContestEvent, SendInvitesForCustomContestState> {
  SendInvitesForCustomContestBloc({
    required this.sendInvitesForCustomContestUsecase,
  }) : super(SendInvitesForCustomContestInitial()) {
    on<SendInvitesForCustomContestEvent>((event, emit) async {
      emit(SendInvitesForCustomContestLoading());
      final failureOrSuccess = await sendInvitesForCustomContestUsecase(SendInvitesForCustomContestParams(contestId: event.contestId, friendsList: event.friendsList));
      emit(
        failureOrSuccess.fold(
            (failure) => SendInvitesForCustomContestFailed(failure: failure),
            (_) => SendInvitesForCustomContestLoaded(),
        ),
      );
    });
  }

  final SendInvitesForCustomContestUsecase sendInvitesForCustomContestUsecase;
}
