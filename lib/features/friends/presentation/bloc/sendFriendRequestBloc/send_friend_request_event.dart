part of 'send_friend_request_bloc.dart';

class SendFriendRequestEvent extends Equatable {
  final String userId;
  const SendFriendRequestEvent({required this.userId});

  @override
  List<Object> get props => [];
}
