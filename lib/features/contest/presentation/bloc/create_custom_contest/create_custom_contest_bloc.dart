import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

part 'create_custom_contest_event.dart';
part 'create_custom_contest_state.dart';

class CreateCustomContestBloc extends Bloc<CreateCustomContestEvent, CreateCustomContestState> {
  CreateCustomContestBloc({
    required this.createCustomContestUsecase,
}) : super(CreateCustomContestInitial()) {
    on<CreateCustomContestEvent>((event, emit) async {
      emit(CreateCustomContestLoading());
      final failureOrSuccess = await createCustomContestUsecase(event.params);
      emit(
        failureOrSuccess.fold(
              (failure) => CreateCustomContestFailed(failure: failure),
              (_) => CreateCustomContestLoaded(),
        )
      );
    });
  }

  final CreateCustomContestUsecase createCustomContestUsecase;
}
