part of 'show_refresh_token_popup_bloc.dart';

abstract class ShowRefreshTokenPopupState extends Equatable {
  const ShowRefreshTokenPopupState();

  @override
  List<Object?> get props => [];
}

class ShowRefreshTokenPopupStateInitial extends ShowRefreshTokenPopupState {}

class ShowRefreshTokenPopupStateLoading extends ShowRefreshTokenPopupState {}

class ShowRefreshTokenPopupStateLoaded extends ShowRefreshTokenPopupState {
  const ShowRefreshTokenPopupStateLoaded({required this.showPopup});

  final bool showPopup;

  @override
  List<Object?> get props => [showPopup];
}

class ShowRefreshTokenPopupStateFailed extends ShowRefreshTokenPopupState {}