part of 'withdraw_friend_request_cubit.dart';

class WithdrawFriendRequestState extends Equatable {
  const WithdrawFriendRequestState();

  @override
  List<Object> get props => [];
}

class WithdrawFriendRequestInitial extends WithdrawFriendRequestState {}

// Add more states in withdraw_friend_request_state.dart
class WithdrawFriendRequestLoading extends WithdrawFriendRequestState {
  final String requestId;

  const WithdrawFriendRequestLoading({required this.requestId});
  @override
  List<Object> get props => [requestId];
}

class WithdrawFriendRequestSuccess extends WithdrawFriendRequestState {
  final String requestId;

  const WithdrawFriendRequestSuccess({required this.requestId});
  @override
  List<Object> get props => [requestId];
}

class WithdrawFriendRequestFailure extends WithdrawFriendRequestState {
  final Failure error;

  const WithdrawFriendRequestFailure(this.error);

  @override
  List<Object> get props => [error];
}
