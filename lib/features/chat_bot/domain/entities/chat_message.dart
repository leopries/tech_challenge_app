import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String text;
  final MessageOwner owner;
  final String id;

  const ChatMessage({
    required this.text,
    required this.owner,
    required this.id,
  });

  @override
  List<Object?> get props => [text, owner, id];
}

enum MessageOwner {
  robot,
  user,
}
