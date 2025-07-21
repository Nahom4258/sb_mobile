import 'package:equatable/equatable.dart';
import '../../../domain/entities/school_entity.dart';

abstract class SchoolState extends Equatable {
  const SchoolState();

  @override
  List<Object?> get props => [];
}

class SchoolInitial extends SchoolState {
  final List<SchoolEntity> schools;

  // By default, it initializes an empty list of schools
  const SchoolInitial({this.schools = const []});

  @override
  List<Object?> get props => [schools];
}

class SchoolsLoading extends SchoolState {}

class SchoolsLoaded extends SchoolState {
  final List<SchoolEntity> schools;

  const SchoolsLoaded({required this.schools});

  @override
  List<Object?> get props => [schools];
}

class SchoolsError extends SchoolState {
  final String message;

  const SchoolsError({required this.message});

  @override
  List<Object?> get props => [message];
}
