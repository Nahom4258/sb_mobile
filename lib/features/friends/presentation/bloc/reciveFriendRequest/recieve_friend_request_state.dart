part of 'recieve_friend_request_bloc.dart';

class RecieveFriendRequestState extends Equatable {
  const RecieveFriendRequestState();

  @override
  List<Object> get props => [];
}

class RecieveFriendRequestInitial extends RecieveFriendRequestState {}

class RecievingFriendRequestState extends RecieveFriendRequestState {}

class FriendRequestRecivedState extends RecieveFriendRequestState {}

class RecieveFriendRequestFailedState extends RecieveFriendRequestState {
  final Failure failure;

  const RecieveFriendRequestFailedState({required this.failure});
}
