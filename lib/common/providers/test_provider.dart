import 'package:get/get.dart';

import '../test_model.dart';

class TestProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Test.fromJson(map);
      if (map is List) return map.map((item) => Test.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Test?> getTest(int id) async {
    final response = await get('test/$id');
    return response.body;
  }

  Future<Response<Test>> postTest(Test test) async => await post('test', test);
  Future<Response> deleteTest(int id) async => await delete('test/$id');
}
