part of 'chat_bloc.dart';

@immutable
abstract class ChatState extends Equatable {
  final List<ChatMessage> chatMessages;

  const ChatState({this.chatMessages = const []});

  @override
  List<Object?> get props => [chatMessages];
}

class ChatIdleState extends ChatState {
  const ChatIdleState({List<ChatMessage> chatMessages = const []})
      : super(chatMessages: chatMessages);
}
