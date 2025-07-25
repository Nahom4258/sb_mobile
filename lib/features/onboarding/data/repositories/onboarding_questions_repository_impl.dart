import 'package:dartz/dartz.dart';
import '../../../../core/error/exeption_to_failure_map.dart';
import '../../../../core/error/failure.dart';
import '../../../features.dart';
import '../../../../core/network/network.dart';
import '../../domain/entities/school_entity.dart';

class OnboardingQuestionsRepositoryImpl
    implements OnboardingQuestionsRepository {
  final AuthenticationLocalDatasource authLocalDatasource;
  final OnboardingQuestionsRemoteDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  OnboardingQuestionsRepositoryImpl({
    required this.authLocalDatasource,
    required this.remoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, UserCredential>> submitOnboardingResponse(
      OnboardingQuestionsResponse onboardingQuestionsResponse) async {
    if (await networkInfo.isConnected) {
      try {
        UserCredentialModel userCredential = await remoteDatasource
            .submitOnboardingQuestions(onboardingQuestionsResponse);

        print(userCredential);

        //call the update
        await authLocalDatasource.updateUserCredntial(
            updatedUserCredntialInformation: userCredential);
        //return
        return Right(userCredential);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<SchoolEntity>>> getSchools(String param) async {
    if (await networkInfo.isConnected) {
      try {
        final schools = await remoteDatasource.getSchools(param);
        return Right(schools);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
