part of 'create_custom_contest_bloc.dart';

class CreateCustomContestEvent extends Equatable {
  const CreateCustomContestEvent({required this.params});

  final CreateCustomContestParams params;

  @override
  List<Object?> get props => [params];
}
