part of 'nlp_bloc.dart';

abstract class NlpEvent extends Equatable {
  const NlpEvent();

  @override
  List<Object> get props => [];
}

class NlpSendEvent extends NlpEvent {
  final String input;

  const NlpSendEvent({required this.input});

  @override
  List<Object> get props => [input];
}
