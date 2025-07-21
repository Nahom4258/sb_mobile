part of 'fetch_custom_contest_detail_bloc.dart';

class FetchCustomContestDetailState extends Equatable {
  const FetchCustomContestDetailState();

  @override
  List<Object> get props => [];
}

class FetchCustomContestDetailInitial extends FetchCustomContestDetailState {

}

class FetchCustomContestDetailLoading extends FetchCustomContestDetailState {}

class FetchCustomContestDetailLoaded extends FetchCustomContestDetailState {
  const FetchCustomContestDetailLoaded({
    required this.customContestDetail,
  });

  final CustomContestDetail customContestDetail;

  @override
  List<Object> get props => [customContestDetail];
}

class FetchCustomContestDetailFailed extends FetchCustomContestDetailState {
  const FetchCustomContestDetailFailed({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}


