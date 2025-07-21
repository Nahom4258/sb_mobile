import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_custom_contest_detail_event.dart';
part 'fetch_custom_contest_detail_state.dart';

class FetchCustomContestDetailBloc extends Bloc<FetchCustomContestDetailEvent, FetchCustomContestDetailState> {
  FetchCustomContestDetailBloc({
    required this.fetchCustomContestDetailUsecase,
}) : super(FetchCustomContestDetailInitial()) {
    on<FetchCustomContestDetailEvent>((event, emit) async {
      emit(FetchCustomContestDetailLoading());
      final failureOrSuccess = await fetchCustomContestDetailUsecase(FetchCustomContestDetailParams(customContestId: event.customContestId));
      emit(
        failureOrSuccess.fold(
              (failure) => FetchCustomContestDetailFailed(failure: failure),
              (customContestDetail) => FetchCustomContestDetailLoaded(customContestDetail: customContestDetail),
        ),
      );
    });
  }

  final FetchCustomContestDetailUsecase fetchCustomContestDetailUsecase;
}
