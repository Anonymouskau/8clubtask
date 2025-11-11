import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://staging.chamberofsecrets.8club.co/v1/",
  ));

  Future<List<dynamic>> fetchExperiences() async {
    final response = await _dio.get(
      "experiences",
      queryParameters: {"active": true},
    );

    // ✅ Extract list correctly
    return response.data["data"]["experiences"] as List<dynamic>;
  }
}
