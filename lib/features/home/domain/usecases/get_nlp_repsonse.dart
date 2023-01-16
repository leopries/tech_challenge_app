import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../chat_bot/domain/entities/tree_node.dart';
import '../../../chat_bot/domain/tree_data_store.dart';
import '../repositories/home_repository.dart';

class GetNlpResponse implements Usecase<TreeNode, String> {
  final HomeRepository _repository;

  const GetNlpResponse(HomeRepository repository) : _repository = repository;

  @override
  Future<Either<Failure, TreeNode>> call(String input) async {
    final response = await _repository.getNlpResponse(input);

    return response.fold(
      (failure) => Left(failure),
      (response) async => await _mapResponseToPathId(response),
    );
  }

  Future<Either<Failure, TreeNode>> _mapResponseToPathId(
      String response) async {
    if (response.contains("Sexualstraftat")) {
      return Right(await TreeDataStore.getSexualAssaultTreeNode());
    }
    return Left(NlpNoPathFound());
  }
}
