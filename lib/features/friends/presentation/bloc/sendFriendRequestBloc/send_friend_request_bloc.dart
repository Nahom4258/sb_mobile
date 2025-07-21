import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/recieve_friend_request_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/send_friend_request_usecase.dart';

part 'send_friend_request_event.dart';
part 'send_friend_request_state.dart';

class SendFriendRequestBloc
    extends Bloc<SendFriendRequestEvent, SendFriendRequestState> {
  final SendFriendRequestUsecase sendFriendRequestUsecase;
  SendFriendRequestBloc({required this.sendFriendRequestUsecase})
      : super(SendFriendRequestInitial()) {
    on<SendFriendRequestEvent>((event, emit) async {
      // final List<String> sentRequests = [];
      // if (state is FriendRequestSentState) {
      //   final ps = (state as FriendRequestSentState).reqeustedUsers;
      //   for (int i = 0; i < ps.length; i++) {
      //     sentRequests.add(ps[i]);
      //   }
      // }
      emit(SendingFriendRequestState(
        userId: event.userId,
      ));
      // final List<String> sentRequestsUpdated = [];
      // if (state is FriendRequestSentState) {
      //   final ps = (state as SendingFriendRequestState).requestedUsers;
      //   for (int i = 0; i < ps.length; i++) {
      //     sentRequestsUpdated.add(ps[i]);
      //   }
      // }
      // sentRequestsUpdated.add(event.userId);
      final failOrRecived = await sendFriendRequestUsecase(
          SendOrRecieveFriendRequestParams(userId: event.userId));

      final recieveState = failOrRecived.fold(
          (l) => SendFriendRequestFailedState(failure: l),
          (r) => FriendRequestSentState(userId: event.userId));

      emit(recieveState);
    });
  }
}
