import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_custom_contest_invitations_event.dart';
part 'fetch_custom_contest_invitations_state.dart';

class FetchCustomContestInvitationsBloc extends Bloc<FetchCustomContestInvitationsEvent, FetchCustomContestInvitationsState> {
  FetchCustomContestInvitationsBloc({
    required this.fetchCustomContestInvitationsUsecase
  }) : super(FetchCustomContestInvitationsInitial()) {
    on<FetchCustomContestInvitationsEvent>((event, emit) async {
      emit(FetchCustomContestInvitationsLoading());
      final failureOrSuccess = await fetchCustomContestInvitationsUsecase(NoParams());
      emit(
        failureOrSuccess.fold(
              (failure) => FetchCustomContestInvitationsFailed(failure: failure),
              (customContestInvitations) => FetchCustomContestInvitationsLoaded(customContestInvitations: customContestInvitations),
        ),
      );
    });
  }

  final FetchCustomContestInvitationsUsecase fetchCustomContestInvitationsUsecase;
}
