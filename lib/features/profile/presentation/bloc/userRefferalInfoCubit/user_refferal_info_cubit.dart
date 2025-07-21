import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_refferal_info_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/get_user_refferal_info_usecase.dart';

part 'user_refferal_info_state.dart';

class UserRefferalInfoCubit extends Cubit<UserRefferalInfoState> {
  final GetUserRefferalInfoUsecase getUserRefferalInfoUsecase;
  UserRefferalInfoCubit({required this.getUserRefferalInfoUsecase})
      : super(UserRefferalInfoInitial());

  void getUserRefferalInfo() async {
    emit((UserRefferalInfoLoading()));
    final channels = await getUserRefferalInfoUsecase(NoParams());
    final state = channels.fold(
      (failure) => UserRefferalInfoFailed(failure: failure),
      (data) => UserRefferalInfoLoaded(userRefferalInfoEntity: data),
    );
    emit(state);
  }
}
