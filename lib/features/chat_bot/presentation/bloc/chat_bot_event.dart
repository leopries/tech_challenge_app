part of 'chat_bot_bloc.dart';

@immutable
abstract class ChatBotEvent extends Equatable {}

class ChatBotChooceOptionEvent extends ChatBotEvent {
  final DecisionOption decisionOption;

  ChatBotChooceOptionEvent({required this.decisionOption});

  @override
  List<Object?> get props => [decisionOption];
}

class ChatBotStartEvent extends ChatBotEvent {
  final TreeNode treeNode;

  ChatBotStartEvent({required this.treeNode});

  @override
  List<Object?> get props => [treeNode];
}

class ChatBotShowDescriptionEvent extends ChatBotEvent {
  final DecisionOption decisionOption;

  ChatBotShowDescriptionEvent({required this.decisionOption});

  @override
  List<Object?> get props => [decisionOption];
}
