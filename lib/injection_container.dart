import "package:get_it/get_it.dart";

import 'features/chat_bot/presentation/bloc/chat/chat_bloc.dart';
import 'features/chat_bot/presentation/bloc/chat_bot_bloc.dart';
import 'features/home/data/data_sources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_nlp_repsonse.dart';
import 'features/home/presentation/bloc/nlp_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Home
  // Bloc
  sl.registerFactory(
    () => NlpBloc(getNlpResponse: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNlpResponse(sl()));

  //Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(),
  );

  //! ChatBot
  // Bloc
  sl.registerFactory(
    () => ChatBotBloc(sl()),
  );

  sl.registerFactory(
    () => ChatBloc(),
  );
}
