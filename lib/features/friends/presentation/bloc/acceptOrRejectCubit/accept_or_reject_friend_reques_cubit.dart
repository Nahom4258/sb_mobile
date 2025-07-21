import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/accept_or_reject_friend_request_usecase.dart';

part 'accept_or_reject_friend_reques_state.dart';

class AcceptOrRejectFriendRequesCubit
    extends Cubit<AcceptOrRejectFriendRequesState> {
  final AcceptOrRejectFriendRequestUsecase acceptOrRejectFriendRequestUsecase;
  AcceptOrRejectFriendRequesCubit(
      {required this.acceptOrRejectFriendRequestUsecase})
      : super(AcceptOrRejectFriendRequesInitial());

  void acceptFriendRequest({required String requestId}) async {
    emit(AcceptFriendRequesLoadingState(requestId: requestId));
    final failOrWithdrawed = await acceptOrRejectFriendRequestUsecase(
      AcceptOrRejectParams(requestId: requestId, acceptRequest: true),
    );
    final state = failOrWithdrawed.fold(
        (l) => AcceptOrRejectFriendRequesFailedState(failure: l),
        (r) => FriendRequestAcceptedState());
    emit(state);
  }

  void rejectFriendRequest({required String requestId}) async {
    emit(RejectFriendRequesLoadingState(requestId: requestId));
    final failOrWithdrawed = await acceptOrRejectFriendRequestUsecase(
      AcceptOrRejectParams(requestId: requestId, acceptRequest: false),
    );
    final state = failOrWithdrawed.fold(
        (l) => AcceptOrRejectFriendRequesFailedState(failure: l),
        (r) => FriendRequestRejectedState());
    emit(state);
  }
}
