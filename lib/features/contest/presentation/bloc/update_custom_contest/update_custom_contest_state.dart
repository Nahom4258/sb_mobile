part of 'update_custom_contest_bloc.dart';

class UpdateCustomContestState extends Equatable {
  const UpdateCustomContestState();

  @override
  List<Object?> get props => [];
}

class UpdateCustomContestInitial extends UpdateCustomContestState {}

class UpdateCustomContestLoading extends UpdateCustomContestState {}
class UpdateCustomContestLoaded extends UpdateCustomContestState {}
class UpdateCustomContestFailed extends UpdateCustomContestState {
  const UpdateCustomContestFailed({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

