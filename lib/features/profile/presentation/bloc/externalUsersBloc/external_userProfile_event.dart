import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ExternalUserProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExternalUserProfile extends ExternalUserProfileEvent {
  final bool isRefreshed;
  final String? userId;

  GetExternalUserProfile({required this.isRefreshed, this.userId});
}
