import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/school_entity.dart';
import '../../../domain/usecases/get_schools_usecase.dart';
import '../../../../../core/error/failure.dart';
import 'schools_event.dart';
import 'schools_state.dart';


class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  final GetSchools getSchoolsUseCase;

  SchoolBloc({required this.getSchoolsUseCase}) : super(SchoolInitial()) {
    on<GetSchoolsEvent>(_onGetSchoolsEvent);
  }

  void _onGetSchoolsEvent(
      GetSchoolsEvent event, Emitter<SchoolState> emit) async {
    // emit(SchoolsLoading());

    final Either<Failure, List<SchoolEntity>> failureOrSchools =
        await getSchoolsUseCase(event.searchParam);

    failureOrSchools.fold(
      (failure) => emit(SchoolsError(message: _mapFailureToMessage(failure))),
      (schools) => emit(SchoolsLoaded(schools: schools)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Map failure to error message, can be more detailed based on failure type
    if (failure is NetworkFailure) {
      return "No Internet connection";
    } else {
      return "Failed to load schools";
    }
  }
}
