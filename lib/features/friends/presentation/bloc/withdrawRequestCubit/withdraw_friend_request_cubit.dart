import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/recieve_friend_request_usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/withdraw_friend_request_usecase%20copy.dart';

part 'withdraw_friend_request_state.dart';

class WithdrawFriendRequestCubit extends Cubit<WithdrawFriendRequestState> {
  final WithdrawFriendRequestUsecase withdrawFriendRequestUsecase;
  WithdrawFriendRequestCubit({required this.withdrawFriendRequestUsecase})
      : super(WithdrawFriendRequestInitial());

  void withdrawRequest(
      {required String requestId, required bool isForUnfriend}) async {
    emit(WithdrawFriendRequestLoading(requestId: requestId));
    final failOrWithdrawed = await withdrawFriendRequestUsecase(
      WithdrawFriendRequestParams(
          userId: requestId, isForunfriend: isForUnfriend),
    );
    final state = failOrWithdrawed.fold((l) => WithdrawFriendRequestFailure(l),
        (r) => WithdrawFriendRequestSuccess(requestId: requestId));
    emit(state);
  }
}
