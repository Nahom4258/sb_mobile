import 'package:equatable/equatable.dart';

abstract class SchoolEvent extends Equatable {
  const SchoolEvent();

  @override
  List<Object?> get props => [];
}

class GetSchoolsEvent extends SchoolEvent {
  final String searchParam;

  const GetSchoolsEvent({required this.searchParam});

  @override
  List<Object?> get props => [searchParam];
}
