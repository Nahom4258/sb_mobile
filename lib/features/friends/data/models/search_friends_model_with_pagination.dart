import 'package:skill_bridge_mobile/features/friends/data/models/search_friends_model.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_search_entity.dart';

class SearchFriendsModelWithPagination extends FriendsSearchEntity {
  const SearchFriendsModelWithPagination(
      {required super.friends,
      required super.numberOfPages,
      required super.currentPage});

  factory SearchFriendsModelWithPagination.fromJson(Map<String, dynamic> json) {
    List<dynamic> searchList = json['users'];

    return SearchFriendsModelWithPagination(
      friends: searchList
          .map((friend) => SearchFriendsModel.fromJson(friend))
          .toList(),
      numberOfPages: json['pagination']['pages'] ?? 1,
      currentPage: json['pagination']['page'] ?? 1,
    );
  }
}
