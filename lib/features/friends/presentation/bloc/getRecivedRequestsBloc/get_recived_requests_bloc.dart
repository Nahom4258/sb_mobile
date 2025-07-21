import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/get_recived_requests_usecase.dart';

part 'get_recived_requests_event.dart';
part 'get_recived_requests_state.dart';

class GetRecivedRequestsBloc
    extends Bloc<GetRecivedRequestsEvent, GetRecivedRequestsState> {
  final GetRecivedRequestsUsecase getRecivedRequestsUsecase;
  GetRecivedRequestsBloc({required this.getRecivedRequestsUsecase})
      : super(GetRecivedRequestsInitial()) {
    on<GetRecivedRequestsEvent>((event, emit) async {
      emit(GetRecivedRequestsLoadingState());
      final listOfFriendsOrFailure =
          await getRecivedRequestsUsecase(NoParams());
      final friendsState = listOfFriendsOrFailure.fold(
          (l) => GetRecivedRequestsFailedState(failure: l),
          (friends) => GetRecivedRequestsLoadedState(friends: friends));
      emit(friendsState);
    });
  }
}
