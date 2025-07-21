part of 'get_sent_requests_bloc.dart';

class GetSentRequestsState extends Equatable {
  const GetSentRequestsState();

  @override
  List<Object> get props => [];
}

class GetSentRequestsInitial extends GetSentRequestsState {}

class GetSentRequestsLoadingState extends GetSentRequestsState {}

class GetSentRequestsLoadedState extends GetSentRequestsState {
  final List<FriendEntity> friends;

  const GetSentRequestsLoadedState({required this.friends});
  @override
  List<Object> get props => [
        friends,
      ];
}

class GetSentRequestsFailedState extends GetSentRequestsState {
  final Failure failure;

  const GetSentRequestsFailedState({required this.failure});
}
