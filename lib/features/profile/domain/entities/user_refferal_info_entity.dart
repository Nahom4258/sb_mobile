import 'package:equatable/equatable.dart';

class UserRefferalInfoEntity extends Equatable {
  final int refferalCount;
  final num totalCoin;

  const UserRefferalInfoEntity({
    required this.refferalCount,
    required this.totalCoin,
  });
  @override
  // []
  List<Object?> get props => [];
}
