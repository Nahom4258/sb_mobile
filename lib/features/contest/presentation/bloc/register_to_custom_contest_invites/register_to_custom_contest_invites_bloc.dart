import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/features/contest/domain/usecases/register_to_custom_contest_invitations_usecase.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'register_to_custom_contest_invites_event.dart';
part 'register_to_custom_contest_invites_state.dart';

class RegisterToCustomContestInvitesBloc extends Bloc<RegisterToCustomContestInvitesEvent, RegisterToCustomContestInvitesState> {
  RegisterToCustomContestInvitesBloc({
    required this.registerToCustomContestInvitesUsecase,
  }) : super(RegisterToCustomContestInvitesInitial()) {
    on<RegisterToCustomContestInvitesEvent>((event, emit) async {
      emit(RegisterToCustomContestInvitesLoading(customContestId: event.customContestId));
      final failureOrSuccess = await registerToCustomContestInvitesUsecase(RegisterToCustomContestInvitesParams(customContestId: event.customContestId));
      emit(
          failureOrSuccess.fold(
              (failure) => RegisterToCustomContestInvitesFailed(failure: failure),
              (_) => RegisterToCustomContestInvitesLoaded(customContestId: event.customContestId),
          )
      );
    });
  }

  final RegisterToCustomContestInvitesUsecase registerToCustomContestInvitesUsecase;
}
