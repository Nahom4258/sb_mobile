part of 'delete_bloc.dart';

abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class DispatchDeleteAccountEvent extends DeleteAccountEvent {}
