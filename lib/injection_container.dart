import "package:get_it/get_it.dart";
import 'package:tech_challenge_app/features/chat_bot/presentation/bloc/chat/chat_bloc.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/bloc/chat_bot_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ChatBot
  // Bloc
  sl.registerFactory(
    () => ChatBotBloc(sl()),
  );

  sl.registerFactory(
    () => ChatBloc(),
  );
}
