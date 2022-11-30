import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatIdleState()) {
    on<ChatEventAddMessage>(_addMessage);
  }

  FutureOr<void> _addMessage(
      ChatEventAddMessage event, Emitter<ChatState> emit) {
    print(event.chatMessage.owner);
    print(event.chatMessage.text);
    emit(
      ChatIdleState(chatMessages: [...state.chatMessages, event.chatMessage]),
    );
  }
}
