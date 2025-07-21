import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/home/domain/usecases/show_refresh_token_popup_usecase.dart';

part 'show_refresh_token_popup_event.dart';
part 'show_refresh_token_popup_state.dart';

class ShowRefreshTokenPopupBloc extends Bloc<ShowRefreshTokenPopupEvent, ShowRefreshTokenPopupState> {
  ShowRefreshTokenPopupBloc({required this.showRefreshTokenPopupUsecase}) : super(ShowRefreshTokenPopupStateInitial()) {
    on<ShowRefreshTokenPopupEvent>((event, emit) async {
      emit(ShowRefreshTokenPopupStateLoading());
      final failureOrSuccess = await showRefreshTokenPopupUsecase(NoParams());
      emit(
        failureOrSuccess.fold(
            (_) => ShowRefreshTokenPopupStateFailed(),
            (showPopup) => ShowRefreshTokenPopupStateLoaded(showPopup: showPopup),
        )
      );
    });
  }

  final ShowRefreshTokenPopupUsecase showRefreshTokenPopupUsecase;
}
