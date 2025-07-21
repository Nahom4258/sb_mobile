import 'package:equatable/equatable.dart';

class WithdrawRequestsEntity extends Equatable {
  final String id;
  final String userId;
  final num ammountInCash;
  final num accountInCoin;
  final String status;
  final DateTime date;
  final String accountId;

  const WithdrawRequestsEntity(
      {required this.id,
      required this.userId,
      required this.ammountInCash,
      required this.accountInCoin,
      required this.status,
      required this.date,
      required this.accountId});

  @override
  List<Object?> get props => [
        id,
        userId,
        ammountInCash,
        accountInCoin,
        status,
        date,
        accountId,
      ];
}
