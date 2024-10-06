import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:routineapp/config/app_config.dart';
import 'package:routineapp/models/category_model.dart';

class CategoryService {
  Future<CategoryResponse?> createCategory(
      CreateCategoryRequest createCategoryRequest) async {
    final String apiUrl = '${AppConfig.apiUrl}category';
    http.Client client = await AppConfig.getHttpClient();

    try {
      final response = await client.post(
        Uri.parse(apiUrl),
        body: jsonEncode(<String, dynamic>{
          'title': createCategoryRequest.title,
          'user_id': createCategoryRequest.userID
        }),
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return CategoryResponse.fromJson(jsonResponse);
      } else {
        return CategoryResponse(message: jsonResponse['message']);
      }
    } catch (e) {
      AppConfig.getLogger().e(e);
      return null;
    }
  }

  Future<List<Category>> getCategories() async {
    http.Client client = await AppConfig.getHttpClient();
    final response =
        await client.get(Uri.parse('${AppConfig.apiUrl}categories'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      List<Category> categories = [];

      if(data['data'] != null) {
        categories = List<Category>.from(
            data['data'].map((categoryData) =>
                Category.fromJson(categoryData)));
      }

      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<CategoryResponse?> deleteCategory(int id) async {
    final String apiUrl = '${AppConfig.apiUrl}category';
    http.Client client = await AppConfig.getHttpClient();

    try {
      final response = await client.delete(Uri.parse("$apiUrl?id=$id"));

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return CategoryResponse.fromJson(jsonResponse);
      } else {
        return CategoryResponse(message: jsonResponse['message']);
      }
    } catch (e) {
      AppConfig.getLogger().e(e);
      return null;
    }
  }

  Future<CategoryResponse?> editCategory(int id, String title) async {
    final String apiUrl = '${AppConfig.apiUrl}category';
    http.Client client = await AppConfig.getHttpClient();

    try {
      final response = await client.put(Uri.parse("$apiUrl?id=$id"), body: jsonEncode(<String, dynamic>{
        'title': title,
      }));

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return CategoryResponse.fromJson(jsonResponse);
      } else {
        return CategoryResponse(message: jsonResponse['message']);
      }
    } catch (e) {
      AppConfig.getLogger().e(e);
      return null;
    }
  }
}
