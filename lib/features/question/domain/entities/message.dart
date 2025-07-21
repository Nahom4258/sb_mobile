import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String content;
  final bool isMessageFromUser;
  final DateTime time;
  final String? tag;

  Message({
    required this.content,
    required this.isMessageFromUser,
    DateTime? time,
    this.tag,
  }) : time = time ?? DateTime.now();

  @override
  List<Object?> get props => [
        content,
        isMessageFromUser,
        time,
        tag,
      ];
}
