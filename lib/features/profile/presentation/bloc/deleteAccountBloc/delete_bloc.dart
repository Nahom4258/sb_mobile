import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/delete_account_usecase.dart';
import '../../../../../core/core.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final ProfileDeleteAccountUsecase profileDeleteAccountUsecase;
  DeleteAccountBloc({required this.profileDeleteAccountUsecase}) : super(DeleteAccountInitial()) {
    on<DispatchDeleteAccountEvent>(_onDispachDeleteAccount);
  }
  _onDispachDeleteAccount(DispatchDeleteAccountEvent event, Emitter<DeleteAccountState> emit) async {
    emit(DeletingState());
    Either<Failure, bool> response = await profileDeleteAccountUsecase(NoParams());
    emit(_eitherFailureOrbool(response));
  }

  DeleteAccountState _eitherFailureOrbool(Either<Failure, bool> response) {
    return response.fold(
        (failure) => DeleteAccountFailedState(errorMessage: failure.errorMessage, failure:failure),
        (r) => DeletedAccountState());
  }
}
