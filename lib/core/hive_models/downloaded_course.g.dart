// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadedCourseAdapter extends TypeAdapter<DownloadedCourse> {
  @override
  final int typeId = 1;

  @override
  DownloadedCourse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedCourse(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedCourse obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.courseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedCourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
