import 'package:equatable/equatable.dart';

class UserAccountsEntity extends Equatable {
  final String id;
  final String userId;
  final String accountNumber;
  final String accountNumberHolder;
  final String bankName;

  const UserAccountsEntity({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.accountNumberHolder,
    required this.bankName,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        accountNumber,
        accountNumberHolder,
        bankName,
      ];
}
