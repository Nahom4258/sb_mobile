import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_nav_event.dart';
part 'home_page_nav_state.dart';

class HomePageNavBloc extends Bloc<HomePageNavEvent, HomePageNavState> {
  HomePageNavBloc() : super(const HomePageNavState(index: 2)) {
    on<HomePageNavEvent>((event, emit) {
      emit(HomePageNavState(index: event.index));
    });
  }
}
