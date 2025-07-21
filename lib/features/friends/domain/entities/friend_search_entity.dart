import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';

class FriendsSearchEntity extends Equatable {
  final List<FriendEntity> friends;
  final int numberOfPages;
  final int currentPage;
  const FriendsSearchEntity({
    required this.friends,
    required this.numberOfPages,
    required this.currentPage,
  });
  @override
  List<Object?> get props => [
        friends,
        currentPage,
        numberOfPages,
      ];
}
