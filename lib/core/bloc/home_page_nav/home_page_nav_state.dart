part of 'home_page_nav_bloc.dart';

class HomePageNavState extends Equatable {
  const HomePageNavState({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}
