import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/onboarding_questions_response.dart';

import '../../../authentication/domain/entities/user_credential.dart';
import '../entities/school_entity.dart';

abstract class OnboardingQuestionsRepository {
  Future<Either<Failure, UserCredential>> submitOnboardingResponse(
      OnboardingQuestionsResponse onboardingQuestionsResponse);
      
  Future<Either<Failure, List<SchoolEntity>>> getSchools(String param);
}
