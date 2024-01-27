
import 'package:teacher/costanse/strings.dart';
import 'package:dio/dio.dart';

class NameWebServise {
  final dio = Dio();

 Future<List<dynamic>> get(String end) async {
    try {
      final response = await dio.get(
        baseUrl + end,
      );

      print(response);
      return response.data;
    } catch (e) {
      print("======dio=======${e.toString()}");
      return [];
    }
  }

   Future<List<dynamic>> post(String end, Object data ) async {
    try {
      final response = await dio.post(
        baseUrl + end ,
        data: data
      );

      print('========$response');
    return [response.data];
    } catch (e) {
      print("======dio=======${e.toString()}");
      return [];
    }
  }
}
