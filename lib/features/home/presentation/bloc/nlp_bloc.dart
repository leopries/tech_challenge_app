import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../chat_bot/domain/entities/tree_node.dart';
import '../../domain/usecases/get_nlp_repsonse.dart';

part 'nlp_event.dart';
part 'nlp_state.dart';

class NlpBloc extends Bloc<NlpEvent, NlpState> {
  GetNlpResponse getNlpResponse;

  NlpBloc({
    required this.getNlpResponse,
  }) : super(NlpInitial()) {
    on<NlpSendEvent>(_mapSendToState);
  }

  Future<FutureOr<void>> _mapSendToState(
      NlpSendEvent event, Emitter<NlpState> emit) async {
    emit(NlpLoading());

    await getNlpResponse(event.input).then((value) {
      value.fold(
        (failure) => emit(NlpError(message: _mapFailureToString(failure))),
        (response) => emit(NlpLoaded(response)),
      );
    });
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Something went wrong on our side. Please try again later.";
      case NlpNoPathFound:
        return "Sorry! We are currenty limited to only few cases.";
      default:
        return "Oops, something went wrong! Please try again later.";
    }
  }
}
