import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../authentication/domain/entities/user_credential.dart';
import '../../domain/entities/onboarding_questions_response.dart';
import '../../domain/usecases/submit_onboarding_questions.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingAnswersState> {
  final SubmitOnbardingQuestionsUsecase submitOnbardingQuestionsUsecase;
  OnboardingBloc({required this.submitOnbardingQuestionsUsecase})
      : super(
          const OnboardingAnswersState(
              subjectsToCover: [],
              validResponse: false,
              reponseSubmissionFailed: false,
              responseSubmitted: false,
              responseSubmitting: false),
        ) {
    on<GradeChangeEvent>(_onGradeLevelChange);
    on<PreparationMethodChangedEvent>(_onPreparationMethodChanged);
    on<DedicationTimeChangedEvent>(_onDedicationTimeChange);
    on<UserMotiveChangedEvent>(_onUserMotiveChange);
    on<StreamChangedEvent>(_onStreamChange);
    on<ReminderTimeChangedEvent>(_onReminderTimeChange);
    on<SubjectsChangedEvent>(_onSubjectsChange);
    on<OnboardingQuestionsResponseSubmittedEvent>(_onSubmitted);
    on<OnContinueButtonPressedEvent>(_onContinue);
   
    on<SchoolChangedEvent>(_onSchoolChanged);
    on<RegionChnagedEvent>(_onRegionChanged);
  }


  void _onSchoolChanged(
      SchoolChangedEvent event, Emitter<OnboardingAnswersState> emit) {
    emit(state.copyWith(highSchool: event.school));
  }

  void _onRegionChanged(
      RegionChnagedEvent event, Emitter<OnboardingAnswersState> emit) {
    emit(state.copyWith(region: event.region));
  }

  void _onGradeLevelChange(
      GradeChangeEvent event, Emitter<OnboardingAnswersState> emit) {
    emit(
      state.copyWith(grade: event.grade),
    );
  }

  void _onPreparationMethodChanged(PreparationMethodChangedEvent event,
      Emitter<OnboardingAnswersState> emit) {
    emit(state.copyWith(preparationMethod: event.preparationMethod));
  }

  void _onDedicationTimeChange(
      DedicationTimeChangedEvent event, Emitter<OnboardingAnswersState> emit) {
    emit(state.copyWith(dedicationTime: event.dedicationTime));
  }

  void _onUserMotiveChange(
      UserMotiveChangedEvent event, Emitter<OnboardingAnswersState> emit) {
    emit(state.copyWith(userMotive: event.userMotive));
  }

  void _onStreamChange(
      StreamChangedEvent event, Emitter<OnboardingAnswersState> emit) {
    emit(state.copyWith(
      stream: event.stream,
      subjectsToCover: [],
    ));
  }

  void _onSubjectsChange(
      SubjectsChangedEvent event, Emitter<OnboardingAnswersState> emit) {
    final subjectIndex = event.subjectIndex;
    List<int> selectedSubjects = List.from(state.subjectsToCover);

    if (selectedSubjects.contains(subjectIndex)) {
      selectedSubjects.remove(subjectIndex);
    } else {
      selectedSubjects.add(event.subjectIndex);
    }

    emit(state.copyWith(subjectsToCover: selectedSubjects));
  }

  void _onReminderTimeChange(
      ReminderTimeChangedEvent event, Emitter<OnboardingAnswersState> emit) {
    emit(state.copyWith(reminderTime: event.reminderTime));
  }

  void _onSubmitted(OnboardingQuestionsResponseSubmittedEvent event,
      Emitter<OnboardingAnswersState> emit) async {
    emit(state.copyWith(responseSubmitting: true));
    // this implementation is temporary
    List<String> chalangingSub = [];

    if (state.stream == 0) {
      for (int i = 0; i < state.subjectsToCover.length; i++) {
        chalangingSub.add(naturalSubjects[state.subjectsToCover[i]].title);
      }
    } else if (state.stream == 1){
      for (int i = 0; i < state.subjectsToCover.length; i++) {
        
        chalangingSub.add(socialSubjects[state.subjectsToCover[i]].title);
      }
    }
    else {
      for (int i = 0; i < state.subjectsToCover.length; i++) {
        chalangingSub.add(grade9and10Subjects[state.subjectsToCover[i]].title);
      }
    }

    OnboardingQuestionsResponse userResponse = OnboardingQuestionsResponse(
      howPrepared: "",
      preferedMethod: "",
      studyTimePerday: "",
      motivation: "",
      id: streamId[state.stream!],
      challengingSubjects: chalangingSub,
      reminderTime: state.reminderTime,
      region: state.region!,
      school: state.highSchool!,
      grade: state.grade!,
    );

    Either<Failure, UserCredential> response =
        await submitOnbardingQuestionsUsecase(
      OnboardingQuestionsParams(onboardingQuestionsResponse: userResponse),
    );
    emit(_eitherFailureOrVoid(response));
    // print(state);
  }

  // I have not used the userCredential
  OnboardingAnswersState _eitherFailureOrVoid(
      Either<Failure, UserCredential> response) {
    return response.fold(
      (failure) => state.copyWith(
          reponseSubmissionFailed: true, responseSubmitting: false),
      (r) => state.copyWith(responseSubmitted: true, responseSubmitting: false),
    );
  }

  void _onContinue(OnContinueButtonPressedEvent event,
      Emitter<OnboardingAnswersState> emit) {
    emit(
      state.copyWith(validResponse: checkFormValidity()),
    );
  }

  bool checkFormValidity() {
    bool isValid = state.grade != null &&
        state.stream != null &&
        state.highSchool != null &&
        state.region != null;
    return isValid;
  }
}
