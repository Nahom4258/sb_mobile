import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'update_custom_contest_event.dart';
part 'update_custom_contest_state.dart';

class UpdateCustomContestBloc extends Bloc<UpdateCustomContestEvent, UpdateCustomContestState> {
  UpdateCustomContestBloc({
    required this.updateCustomContestUsecase,
}) : super(UpdateCustomContestInitial()) {
    on<UpdateCustomContestEvent>((event, emit) async {
      emit(UpdateCustomContestLoading());
      final failureOrSuccess = await updateCustomContestUsecase(event.params);
      emit(
        failureOrSuccess.fold(
                (failure) => UpdateCustomContestFailed(failure: failure),
                (_) => UpdateCustomContestLoaded(),
        )
      );
    });
  }

  final UpdateCustomContestUsecase updateCustomContestUsecase;
}
