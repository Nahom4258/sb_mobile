import '../../../features.dart';

class ChatResponseModel extends ChatResponse {
  const ChatResponseModel({
    required super.messageResponse,
    super.tag,
  });

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    final responseJson = json['history'] ?? [];
    return ChatResponseModel(
      messageResponse:
          responseJson[responseJson.length - 1][1]['message'] ?? '',
      tag: responseJson[responseJson.length - 1][1]['tag'],
    );
  }

  @override
  List<Object> get props => [messageResponse];
}
