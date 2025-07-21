import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_cashout_requests_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/cashout_requests_usecase.dart';

part 'cashout_requests_event.dart';
part 'cashout_requests_state.dart';

class CashoutRequestsBloc
    extends Bloc<CashoutRequestsEvent, CashoutRequestsState> {
  final CashoutRequestsUsecase cashoutRequestsUsecase;
  CashoutRequestsBloc({required this.cashoutRequestsUsecase})
      : super(CashoutRequestsInitial()) {
    on<getCashoutRequestsEvent>((event, emit) async {
      emit(CashoutRequestsLoadingState());
      final requests = await cashoutRequestsUsecase(NoParams());
      requests.fold(
        (failure) => emit(
          CashoutRequestsFailedState(failure: failure),
        ),
        (userCashoutRequestsEntity) => emit(
          CashoutRequestsLoadedState(
            userCashoutRequestsEntity: userCashoutRequestsEntity,
          ),
        ),
      );
    });
  }
}
