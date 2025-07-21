part of 'user_refferal_info_cubit.dart';

class UserRefferalInfoState extends Equatable {
  const UserRefferalInfoState();

  @override
  List<Object> get props => [];
}

class UserRefferalInfoInitial extends UserRefferalInfoState {}

class UserRefferalInfoLoading extends UserRefferalInfoState {}

class UserRefferalInfoLoaded extends UserRefferalInfoState {
  final UserRefferalInfoEntity userRefferalInfoEntity;

  const UserRefferalInfoLoaded({required this.userRefferalInfoEntity});
  @override
  List<Object> get props => [userRefferalInfoEntity];
}

class UserRefferalInfoFailed extends UserRefferalInfoState {
  final Failure failure;

  const UserRefferalInfoFailed({required this.failure});
  @override
  List<Object> get props => [failure];
}
