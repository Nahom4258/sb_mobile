part of 'delete_custom_contest_by_id_bloc.dart';

class DeleteCustomContestByIdEvent extends Equatable {
  const DeleteCustomContestByIdEvent({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
