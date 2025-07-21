import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/get_all_friends_usecase.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<GetFriendsEvent, FriendsState> {
  final GetAllFriendsUsecase getAllFriendsUsecase;
  FriendsBloc({required this.getAllFriendsUsecase}) : super(FriendsInitial()) {
    on<GetFriendsEvent>((event, emit) async {
      emit(FriendsLoadingState());
      final listOfFriendsOrFailure = await getAllFriendsUsecase(NoParams());
      final friendsState = listOfFriendsOrFailure.fold(
          (l) => FriendsLoadingFailedState(),
          (friends) => FriendsLoadedState(friends: friends));
      emit(friendsState);
    });
  }
}
