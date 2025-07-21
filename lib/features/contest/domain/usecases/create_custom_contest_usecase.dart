import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

class CreateCustomContestUsecase
    extends UseCase<Unit, CreateCustomContestParams> {
  final ContestRepository contestRepository;

  CreateCustomContestUsecase({required this.contestRepository});
  @override
  Future<Either<Failure, Unit>> call(CreateCustomContestParams params) async {
    return await contestRepository.createCustomContest(
      params: params,
    );
  }
}

class CreateCustomContestParams extends Equatable {
  const CreateCustomContestParams({
    required this.title,
    required this.description,
    required this.startsAt,
    required this.endsAt,
    required this.questions,
  });

  final String title;
  final String description;
  final DateTime startsAt;
  final DateTime endsAt;
  final Map<String, int> questions;


  @override
  List<Object> get props => [title, description, startsAt, endsAt, questions];
}
