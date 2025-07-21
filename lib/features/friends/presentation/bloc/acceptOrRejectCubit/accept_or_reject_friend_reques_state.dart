part of 'accept_or_reject_friend_reques_cubit.dart';

class AcceptOrRejectFriendRequesState extends Equatable {
  const AcceptOrRejectFriendRequesState();

  @override
  List<Object> get props => [];
}

class AcceptOrRejectFriendRequesInitial
    extends AcceptOrRejectFriendRequesState {}

class AcceptFriendRequesLoadingState extends AcceptOrRejectFriendRequesState {
  final String requestId;

  const AcceptFriendRequesLoadingState({required this.requestId});
  @override
  List<Object> get props => [requestId];
}

class RejectFriendRequesLoadingState extends AcceptOrRejectFriendRequesState {
  final String requestId;

  const RejectFriendRequesLoadingState({required this.requestId});
  @override
  List<Object> get props => [requestId];
}

class FriendRequestAcceptedState extends AcceptOrRejectFriendRequesState {}

class FriendRequestRejectedState extends AcceptOrRejectFriendRequesState {}

class AcceptOrRejectFriendRequesFailedState
    extends AcceptOrRejectFriendRequesState {
  final Failure failure;

  const AcceptOrRejectFriendRequesFailedState({required this.failure});
  @override
  List<Object> get props => [failure];
}
