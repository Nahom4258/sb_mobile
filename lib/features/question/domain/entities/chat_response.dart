import 'package:equatable/equatable.dart';

class ChatResponse extends Equatable {
  final String messageResponse;
  final String? tag;

  const ChatResponse({required this.messageResponse, this.tag});

  @override
  List<Object?> get props => [
        messageResponse,
        tag,
      ];
}
