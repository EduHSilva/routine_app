import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:routineapp/models/response.dart';
import 'package:routineapp/models/tasks/category_model.dart';
import 'package:routineapp/viewmodels/category_viewmodel.dart';
import '../../../config/helper.dart';
import '../../../widgets/custom_modal_input.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  CategoryTabState createState() => CategoryTabState();
}

class CategoryTabState extends State<CategoryTab> {
  final CategoryViewModel _categoryViewModel = CategoryViewModel();

  @override
  void initState() {
    super.initState();
    _categoryViewModel.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _categoryViewModel.isLoading,
      builder: (context, isLoading, child) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ValueListenableBuilder<List<Category>>(
          valueListenable: _categoryViewModel.categories,
          builder: (context, categories, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text('categories'.tr()),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _showCategoryDialog(null);
                    },
                  ),
                ],
              ),
              body: categories.isEmpty
                  ? Center(child: Text('noData'.tr()))
                  : ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(category.title),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _showCategoryDialog(category);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteCategoryDialog(category);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        );
      },
    );
  }

  void _showCategoryDialog(Category? category) {
    final isEdit = category != null;
    showDialog(
      context: context,
      builder: (context) {
        return CustomModalInput(
          title: isEdit ? 'edit' : 'add',
          hintTexts: const ['name'],
          initialValues: isEdit ? {'name': category.title} : null,
          onConfirm: (values) {
            if (isEdit) {
              _categoryViewModel
                  .editCategory(category.id, values['name']!)
                  .then((response) {
                _handleResponse(response);
              });
            } else {
              _categoryViewModel
                  .createCategory(values['name']!)
                  .then((response) {
                _handleResponse(response);
              });
            }
          },
          isForm: true,
        );
      },
    );
  }

  void _deleteCategoryDialog(Category category) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomModalInput(
            title: "attention",
            hintTexts: const ['confirmDelete'],
            onConfirm: (_) {
              _categoryViewModel.deleteCategory(category.id).then((response) {
                _handleResponse(response);
              });
            },
            isWarn: true);
      },
    );
  }

  void _handleResponse(CategoryResponse? response) {
    if (response?.category != null) {
      _categoryViewModel.fetchCategories();
    } else {
      if (!mounted) return;
      showErrorBar(context, response);
    }
  }
}
