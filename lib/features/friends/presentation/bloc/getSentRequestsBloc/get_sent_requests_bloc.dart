import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/get_sent_requests_usecase.dart';

part 'get_sent_requests_event.dart';
part 'get_sent_requests_state.dart';

class GetSentRequestsBloc
    extends Bloc<GetSentRequestsEvent, GetSentRequestsState> {
  final GetSentRequestsUsecase getSentRequestsUsecase;
  GetSentRequestsBloc({required this.getSentRequestsUsecase})
      : super(GetSentRequestsInitial()) {
    on<GetSentRequestsEvent>((event, emit) async {
      emit(GetSentRequestsLoadingState());
      final listOfFriendsOrFailure = await getSentRequestsUsecase(NoParams());
      final friendsState = listOfFriendsOrFailure.fold(
          (l) => GetSentRequestsFailedState(failure: l),
          (friends) => GetSentRequestsLoadedState(friends: friends));
      emit(friendsState);
    });
  }
}
