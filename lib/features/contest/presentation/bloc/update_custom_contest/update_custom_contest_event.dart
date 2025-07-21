part of 'update_custom_contest_bloc.dart';

class UpdateCustomContestEvent extends Equatable {
  const UpdateCustomContestEvent({
    required this.params,
  });

  final UpdateCustomContestParams params;

  @override
  List<Object?> get props => [params];
}
