import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_profile_entity_get.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/externalUsersBloc/external_userProfile_event.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/externalUsersBloc/external_userProfile_state.dart';

class ExternalUsersBloc
    extends Bloc<ExternalUserProfileEvent, ExternalUserProfileState> {
  final GetProfileUsecase getProfileUsecase;

  ExternalUsersBloc({
    required this.getProfileUsecase,
  }) : super(ProfileEmpty()) {
    on<GetExternalUserProfile>(mapEventToState);
  }

  mapEventToState(GetExternalUserProfile event,
      Emitter<ExternalUserProfileState> emit) async {
    emit(ExternalUserProfileLoading());

    final failureOrData = await getProfileUsecase(GetUserProfileParams(
        isRefreshed: event.isRefreshed, userId: event.userId));
    emit(_eitherLoadedOrErrorState(failureOrData));
  }

  ExternalUserProfileState _eitherLoadedOrErrorState(
    Either<Failure, UserProfile> failureOrData,
  ) {
    return failureOrData.fold(
        (failure) => ExternalUserProfileFailedState(
            errorMessage: failure.errorMessage, failure: failure),
        (userProfile) => ExternalUserProfileLoaded(userProfile: userProfile));
  }
}
