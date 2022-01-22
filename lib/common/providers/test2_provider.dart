import 'package:get/get.dart';

import '../test2_model.dart';

class Test2Provider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Test2.fromJson(map);
      if (map is List) return map.map((item) => Test2.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Test2?> getTest2(int id) async {
    final response = await get('test2/$id');
    return response.body;
  }

  Future<Response<Test2>> postTest2(Test2 test2) async =>
      await post('test2', test2);
  Future<Response> deleteTest2(int id) async => await delete('test2/$id');
}
