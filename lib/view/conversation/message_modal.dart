class Message {
  final DateTime dateTime;
  final String content;
  final MessageType type;
  final bool isClientMessage;

  Message({
    required this.dateTime,
    required this.content,
    required this.type,
    required this.isClientMessage,
  });
}

enum MessageType {
  text,
  audio,
  imageVideo,
  file,
  productLink,
  link,
}
