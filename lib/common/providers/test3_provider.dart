import 'package:get/get.dart';

import '../test3_model.dart';

class Test3Provider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Test3.fromJson(map);
      if (map is List) return map.map((item) => Test3.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Test3?> getTest3(int id) async {
    final response = await get('test3/$id');
    return response.body;
  }

  Future<Response<Test3>> postTest3(Test3 test3) async =>
      await post('test3', test3);
  Future<Response> deleteTest3(int id) async => await delete('test3/$id');
}
