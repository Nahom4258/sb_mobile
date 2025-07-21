import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';

import '../entities/school_entity.dart';
import '../repositories/onboarding_questions_repositories.dart';

class GetSchools {
  final OnboardingQuestionsRepository repository;

  GetSchools({required this.repository});

  Future<Either<Failure, List<SchoolEntity>>> call(String param) async {
    return await repository.getSchools(param);
  }
}
