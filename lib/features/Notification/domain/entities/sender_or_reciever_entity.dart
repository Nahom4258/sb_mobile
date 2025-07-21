import 'package:equatable/equatable.dart';

class SenderOrRecieverEntity extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String? avatar;

  const SenderOrRecieverEntity(
      {required this.id,
      required this.name,
      required this.lastName,
      this.avatar});

  @override
  List<Object?> get props => [
        id,
        name,
        lastName,
        avatar,
      ];
}
