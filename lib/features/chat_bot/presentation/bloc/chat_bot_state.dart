part of 'chat_bot_bloc.dart';

@immutable
abstract class ChatBotState extends Equatable {
  const ChatBotState();

  @override
  List<Object?> get props => [];
}

class ChatBotLoading extends ChatBotState {}

class ChatBotLoaded extends ChatBotState {
  final TreeNode treeNode;

  const ChatBotLoaded({required this.treeNode});

  @override
  List<Object?> get props => [...super.props, treeNode];
}

class ChatBotFinal extends ChatBotLoaded {
  final String message;

  const ChatBotFinal({
    required this.message,
    required TreeNode treeNode,
  }) : super(treeNode: treeNode);

  @override
  List<Object?> get props => [...super.props, treeNode];
}
