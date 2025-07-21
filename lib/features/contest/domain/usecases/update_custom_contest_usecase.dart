import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

class UpdateCustomContestUsecase
    extends UseCase<Unit, UpdateCustomContestParams> {
  final ContestRepository contestRepository;

  UpdateCustomContestUsecase({required this.contestRepository});
  @override
  Future<Either<Failure, Unit>> call(UpdateCustomContestParams params) async {
    return await contestRepository.updateCustomContest(
      params: params,
    );
  }
}

class UpdateCustomContestParams extends Equatable {
  const UpdateCustomContestParams({
    required this.id,
    required this.title,
    required this.description,
    required this.startsAt,
    required this.endsAt,
    required this.questions,
  });

  final String id;
  final String title;
  final String description;
  final DateTime startsAt;
  final DateTime endsAt;
  final Map<String, int> questions;


  @override
  List<Object> get props => [id, title, description, startsAt, endsAt, questions];
}
