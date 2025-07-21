part of 'get_recived_requests_bloc.dart';

class GetRecivedRequestsState extends Equatable {
  const GetRecivedRequestsState();

  @override
  List<Object> get props => [];
}

class GetRecivedRequestsInitial extends GetRecivedRequestsState {}

class GetRecivedRequestsLoadingState extends GetRecivedRequestsState {}

class GetRecivedRequestsLoadedState extends GetRecivedRequestsState {
  final List<FriendEntity> friends;

  const GetRecivedRequestsLoadedState({required this.friends});
  @override
  List<Object> get props => [
        friends,
      ];
}

class GetRecivedRequestsFailedState extends GetRecivedRequestsState {
  final Failure failure;

  const GetRecivedRequestsFailedState({required this.failure});
}
