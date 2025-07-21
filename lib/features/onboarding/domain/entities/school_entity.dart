import 'package:equatable/equatable.dart';

class SchoolEntity extends Equatable {
  final String id;
  final String name;
  final String region;

  const SchoolEntity({
    required this.id,
    required this.name,
    required this.region,
  });

  @override
  List<Object> get props => [id, name, region];

  // Factory method to create a SchoolEntity from a JSON map
  factory SchoolEntity.fromJson(Map<String, dynamic> json) {
    return SchoolEntity(
      id: json['_id'],
      name: json['name'],
      region: json['region'],
    );
  }

  // Method to convert a SchoolEntity to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'region': region,
    };
  }
}
