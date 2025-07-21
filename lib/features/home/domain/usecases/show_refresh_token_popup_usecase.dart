import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

class ShowRefreshTokenPopupUsecase extends UseCase<bool, NoParams> {
  ShowRefreshTokenPopupUsecase({required this.homeRepository});

  final HomeRepository homeRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await homeRepository.showRefreshTokenPopup();
  }
}