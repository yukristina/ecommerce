import 'package:dio/dio.dart';
import 'package:ecommerce/core/api.dart';
import 'package:ecommerce/data/models/user_model.dart';

class CategoryRepository {
  final Api _api = Api();

  // fetch all categories
  Future<List<UserModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => UserModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
