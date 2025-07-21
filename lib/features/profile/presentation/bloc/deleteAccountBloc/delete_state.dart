part of 'delete_bloc.dart';



abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

class DeletedAccountState extends DeleteAccountState {}

class DeleteAccountFailedState extends DeleteAccountState {
  final String errorMessage;
  final Failure failure;

  const DeleteAccountFailedState({required this.errorMessage, required this.failure});
}

class DeletingState extends DeleteAccountState {}
