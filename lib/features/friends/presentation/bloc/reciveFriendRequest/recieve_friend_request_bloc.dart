import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/recieve_friend_request_usecase.dart';

part 'recieve_friend_request_event.dart';
part 'recieve_friend_request_state.dart';

class RecieveFriendRequestBloc
    extends Bloc<RecieveFriendRequestEvent, RecieveFriendRequestState> {
  final RecieveFriendRequestUsecase recieveFriendRequestUsecase;
  RecieveFriendRequestBloc({required this.recieveFriendRequestUsecase})
      : super(RecieveFriendRequestInitial()) {
    on<RecieveFriendRequestEvent>((event, emit) async {
      emit(RecievingFriendRequestState());
      final failOrRecived = await recieveFriendRequestUsecase(
          SendOrRecieveFriendRequestParams(userId: event.userId));
      final recieveState = failOrRecived.fold(
          (l) => RecieveFriendRequestFailedState(failure: l),
          (r) => FriendRequestRecivedState());

      emit(recieveState);
    });
  }
}
