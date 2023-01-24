import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/decision_option.dart';
import '../../domain/entities/tree_node.dart';
import '../../domain/tree_traverser.dart';
import 'chat/chat_bloc.dart';

part 'chat_bot_event.dart';
part 'chat_bot_state.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final ChatBloc chatBloc;
  late TreeTraverser _treeTraverser;

  ChatBotBloc(
    this.chatBloc,
  ) : super(ChatBotLoading()) {
    on<ChatBotChooceOptionEvent>(_chooseOption);
    on<ChatBotStartEvent>(_start);
  }

  FutureOr<void> _chooseOption(
      ChatBotChooceOptionEvent event, Emitter<ChatBotState> emit) {
    final newNode = _treeTraverser.chooseOption(event.decisionOption);
    if (event.decisionOption.description?.text != null) {
      chatBloc.add(
        ChatEventAddMessage(
          chatMessage: ChatMessage(
            text: event.decisionOption.description?.text ?? "",
            owner: MessageOwner.user,
            id: const Uuid().v4(),
          ),
        ),
      );
    }
    if (newNode.question != null) {
      chatBloc.add(
        ChatEventAddMessage(
          chatMessage: ChatMessage(
            text: newNode.question!,
            owner: MessageOwner.robot,
            id: const Uuid().v4(),
          ),
        ),
      );
    }
    if (newNode.decisionOutcome != null &&
        newNode.decisionOutcome!.successful) {
      chatBloc.add(
        ChatEventAddMessage(
          chatMessage: ChatMessage(
            text: newNode.decisionOutcome!.outcomeResult!,
            owner: MessageOwner.robot,
            id: const Uuid().v4(),
          ),
        ),
      );
      emit(
        ChatBotFinal(
          treeNode: newNode,
          message: newNode.decisionOutcome!.outcomeResult!,
        ),
      );
    } else if (newNode.decisionOutcome != null &&
        !newNode.decisionOutcome!.successful) {
      chatBloc.add(
        ChatEventAddMessage(
          chatMessage: ChatMessage(
            text:
                "Tut mir leid, leider kann ich deine Beschreibung keinen Paragrafen zuordnen.\n\nBitte wende dich an eine Studentischen Rechtsberatungen um deine Frage zu klären",
            owner: MessageOwner.robot,
            id: const Uuid().v4(),
          ),
        ),
      );
    }

    emit(ChatBotLoaded(treeNode: newNode));
  }

  FutureOr<void> _start(ChatBotStartEvent event, Emitter<ChatBotState> emit) {
    _treeTraverser = TreeTraverser(event.treeNode);
    if (event.treeNode.question != null) {
      chatBloc.add(
        ChatEventAddMessage(
          chatMessage: ChatMessage(
            text: event.treeNode.question!,
            owner: MessageOwner.robot,
            id: const Uuid().v4(),
          ),
        ),
      );
    }
    emit(ChatBotLoaded(treeNode: event.treeNode));
  }
}
