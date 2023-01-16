import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, String>> getNlpResponse(String input);
}