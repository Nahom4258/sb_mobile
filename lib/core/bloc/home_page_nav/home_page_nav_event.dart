part of 'home_page_nav_bloc.dart';

class HomePageNavEvent extends Equatable {


  final int index;

  const HomePageNavEvent({required this.index});

  @override
  List<Object> get props => [index];
}
