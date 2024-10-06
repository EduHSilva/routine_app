import 'package:routineapp/models/category_model.dart';
import 'package:routineapp/services/category_service.dart';

class CategoryViewModel {
  final CategoryService _categoryService = CategoryService();

  Future<CategoryResponse?> createCategory(String title) async {
    CreateCategoryRequest categoryRequest = CreateCategoryRequest(title: title);
    CategoryResponse? response =
        await _categoryService.createCategory(categoryRequest);

    return response;
  }

    Future<List<Category>> getCategories() async {
    List<Category> response =
        await _categoryService.getCategories();

    return response;
  }

  Future<CategoryResponse?> deleteCategory(int id) async {
    CategoryResponse? response = await _categoryService.deleteCategory(id);

    return response;
  }

  Future<CategoryResponse?> editCategory(int id, String title) async {
    CategoryResponse? response = await _categoryService.editCategory(id, title);

    return response;
  }
}
