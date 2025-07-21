part of 'delete_custom_contest_by_id_bloc.dart';

class DeleteCustomContestByIdState extends Equatable {
  const DeleteCustomContestByIdState();

  @override
  List<Object?> get props => [];
}

class DeleteCustomContestByIdInitial extends DeleteCustomContestByIdState {}
class DeleteCustomContestByIdLoading extends DeleteCustomContestByIdState {}
class DeleteCustomContestByIdLoaded extends DeleteCustomContestByIdState {}
class DeleteCustomContestByIdFailed extends DeleteCustomContestByIdState {
  const DeleteCustomContestByIdFailed({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
