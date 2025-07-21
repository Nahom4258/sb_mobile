import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';

import '../../../../../core/core.dart';

part 'delete_custom_contest_by_id_event.dart';
part 'delete_custom_contest_by_id_state.dart';

class DeleteCustomContestByIdBloc extends Bloc<DeleteCustomContestByIdEvent, DeleteCustomContestByIdState> {
  DeleteCustomContestByIdBloc({
    required this.deleteCustomContestByIdUsecase,
  }) : super(DeleteCustomContestByIdInitial()) {
    on<DeleteCustomContestByIdEvent>((event, emit) async {
      emit(DeleteCustomContestByIdLoading());
      final failureOrSuccess = await deleteCustomContestByIdUsecase(DeleteCustomContestByIdParams(customContestId: event.customContestId));
      emit(
        failureOrSuccess.fold(
            (failure) => DeleteCustomContestByIdFailed(failure: failure),
            (_) => DeleteCustomContestByIdLoaded(),
        ),
      );
    });
  }

  final DeleteCustomContestByIdUsecase deleteCustomContestByIdUsecase;
}
