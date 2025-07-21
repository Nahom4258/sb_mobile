part of 'send_friend_request_bloc.dart';

class SendFriendRequestState extends Equatable {
  const SendFriendRequestState();

  @override
  List<Object> get props => [];
}

class SendFriendRequestInitial extends SendFriendRequestState {}

class SendingFriendRequestState extends SendFriendRequestState {
  final String userId;

  const SendingFriendRequestState({required this.userId});
  @override
  List<Object> get props => [userId];
}

class FriendRequestSentState extends SendFriendRequestState {
  final String userId;

  const FriendRequestSentState({required this.userId});
  @override
  List<Object> get props => [userId];
}

class SendFriendRequestFailedState extends SendFriendRequestState {
  final Failure failure;

  const SendFriendRequestFailedState({required this.failure});
}
