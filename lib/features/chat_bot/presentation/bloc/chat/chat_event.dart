part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatEventAddMessage extends ChatEvent {
  final ChatMessage chatMessage;

  const ChatEventAddMessage({required this.chatMessage});

  @override
  List<Object?> get props => [...super.props, chatMessage];
}
