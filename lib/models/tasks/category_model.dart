import 'package:routineapp/config/app_config.dart';
import 'package:routineapp/models/response.dart';

class Category {
  final int id;
  final String? createAt;
  final String? deletedAt;
  final String? updateAt;
  String title;

  Category({
    required this.id,
    this.createAt,
    this.deletedAt,
    this.updateAt,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      createAt: json['createAt'],
      deletedAt: json['deletedAt'],
      updateAt: json['updateAt'],
      title: json['title'],
    );
  }
}

class CategoryResponse extends DefaultResponse {
  Category? category;

  CategoryResponse({
    this.category,
    required super.message,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      category: Category?.fromJson(json['data']),
      message: json['message'],
    );
  }
}


class CreateCategoryRequest {
  final String title;
  final int userID = AppConfig.user!.id;

  CreateCategoryRequest({required this.title});
}
