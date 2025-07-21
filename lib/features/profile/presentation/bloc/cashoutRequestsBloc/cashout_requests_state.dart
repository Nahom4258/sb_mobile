part of 'cashout_requests_bloc.dart';

class CashoutRequestsState extends Equatable {
  const CashoutRequestsState();

  @override
  List<Object> get props => [];
}

class CashoutRequestsInitial extends CashoutRequestsState {}

class CashoutRequestsLoadingState extends CashoutRequestsState {}

class CashoutRequestsLoadedState extends CashoutRequestsState {
  final UserCashoutRequestsEntity userCashoutRequestsEntity;

  const CashoutRequestsLoadedState({required this.userCashoutRequestsEntity});
  @override
  List<Object> get props => [
        userCashoutRequestsEntity,
      ];
}

class CashoutRequestsFailedState extends CashoutRequestsState {
  final Failure failure;

  const CashoutRequestsFailedState({required this.failure});
  @override
  List<Object> get props => [
        failure,
      ];
}
