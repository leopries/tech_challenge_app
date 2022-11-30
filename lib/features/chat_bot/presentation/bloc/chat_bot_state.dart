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
