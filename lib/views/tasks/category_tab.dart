import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:routineapp/config/app_config.dart';
import 'package:routineapp/config/helper.dart';
import 'package:routineapp/models/category_model.dart';
import 'package:routineapp/viewmodels/category_viewmodel.dart';

import '../../widgets/custom_modal_input.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  CategoryTabState createState() => CategoryTabState();
}

class CategoryTabState extends State<CategoryTab> {
  final CategoryViewModel _categoryViewModel = CategoryViewModel();
  List<Category> _categories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getCategories();
    });
  }

  void _getCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Category> response = await _categoryViewModel.getCategories();

      setState(() {
        _categories = response;
      });
    } catch (e) {
      AppConfig.getLogger().e(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addCategory(String title) async {
    setState(() {
      _isLoading = true;
    });

    try {
      CategoryResponse? response =
          await _categoryViewModel.createCategory(title);
      if (response?.category != null) {
        _getCategories();
      } else {
        if (!mounted) return;
        showErrorBar(context, response);
      }
    } catch (e) {
      AppConfig.getLogger().e(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _editCategory(int id, String title) async {
    setState(() {
      _isLoading = true;
    });

    try {
      CategoryResponse? response =
          await _categoryViewModel.editCategory(id, title);
      if (response?.category != null) {
        _getCategories();
      } else {
        if (!mounted) return;
        showErrorBar(context, response);
      }
    } catch (e) {
      AppConfig.getLogger().e(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deleteCategory(int id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      CategoryResponse? response = await _categoryViewModel.deleteCategory(id);
      if (response?.category != null) {
        _getCategories();
      } else {
        if (!mounted) return;
        showErrorBar(context, response);
      }
    } catch (e) {
      AppConfig.getLogger().e(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
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
            body: _categories.isEmpty
                ? Center(child: Text('noData'.tr()))
                : ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];

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
              _editCategory(category.id, values['name']!);
            } else {
              _addCategory(values['name']!);
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
              _deleteCategory(category.id);
            },
            isWarn: true);
      },
    );
  }
}
