import '../../../../core/network/api_service.dart';

abstract class HomeRemoteDataSource {
  Future<String> nlpRequest(String input);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<String> nlpRequest(String input) async {
    final result = await ApiService.postRequest("", body: {"prompt": input});

    return (result["choices"] as List).first?["text"];
  }
}
