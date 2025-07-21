part of 'create_custom_contest_bloc.dart';

class CreateCustomContestState extends Equatable {
  const CreateCustomContestState();

  @override
  List<Object?> get props => [];
}

class CreateCustomContestInitial extends CreateCustomContestState {}

class CreateCustomContestLoading extends CreateCustomContestState {}
class CreateCustomContestLoaded extends CreateCustomContestState {}
class CreateCustomContestFailed extends CreateCustomContestState {
  const CreateCustomContestFailed({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
