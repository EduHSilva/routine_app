import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:routineapp/widgets/custom_text_field.dart';

import '../../../viewmodels/tasks_viewmodel.dart';
import '../../config/app_config.dart';
import '../../config/helper.dart';
import '../../models/enums.dart';
import '../../models/tasks/category_model.dart';
import '../../models/tasks/task_model.dart';
import '../../viewmodels/category_viewmodel.dart';
import '../../widgets/custom_dropdown.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  NewTaskViewState createState() => NewTaskViewState();
}

class NewTaskViewState extends State<NewTaskView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getCategories();
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TasksViewModel _tasksViewModel = TasksViewModel();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  bool _isLoading = false;

  DropdownItem<Category>? _selectedCategory;
  DropdownItem<Priority>? _selectedPriority;
  DropdownItem<Frequency>? _selectedFrequency;

  final List<DropdownItem<Category>> _categories = [];

  final List<DropdownItem<Priority>> _priorities = Priority.values
      .map((priority) => DropdownItem(
            label: priority.label,
            value: priority,
          ))
      .toList();

  final List<DropdownItem<Frequency>> _frequencies = Frequency.values
      .map((priority) => DropdownItem(
            label: priority.label,
            value: priority,
          ))
      .toList();

  void _getCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Category> response = [];

      setState(() {
        for(Category category in response) {
          _categories.add(DropdownItem(label: category.title, value: category));
        }
      });
    } catch (e) {
      AppConfig.getLogger().e(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addRule() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        if (_selectedCategory == null ||
            _selectedPriority == null ||
            _selectedFrequency == null) {
          return;
        }
        await _tasksViewModel.addRule(CreateTaskRequest(title: _titleController.text,
            categoryID: _selectedCategory!.value.id,
            dateStart: _startDateController.text, dateEnd: _endDateController.text,
            frequency: _selectedFrequency!.value.label,
            priority: _selectedPriority!.value.label, startTime: _startTimeController.text));

        Navigator.pop(context, true);
      } catch (e) {
        AppConfig.getLogger().e(e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add'.tr()),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'newTask'.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _titleController,
                      labelText: 'title',
                      validator: requiredFieldValidator,
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown(
                      labelText: 'category',
                      items: _categories,
                      selectedItem: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = _categories
                              .firstWhere((item) => item.value == value);
                        });
                      },
                        validator: (value) =>
                        value == null ? 'Select a category' : null
                    ),
                    const SizedBox(height: 16),
                    // Colocando datas em duas colunas
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _startDateController,
                            labelText: 'startDate'.tr(),
                            readOnly: true,
                            onTap: () =>
                                _selectDate(context, _startDateController),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            controller: _endDateController,
                            labelText: 'endDate'.tr(),
                            readOnly: true,
                            onTap: () =>
                                _selectDate(context, _endDateController),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Colocando horas em duas colunas
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _startTimeController,
                            labelText: 'startTime'.tr(),
                            readOnly: true,
                            onTap: () =>
                                _selectTime(context, _startTimeController),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            controller: _endTimeController,
                            labelText: 'endTime'.tr(),
                            readOnly: true,
                            onTap: () =>
                                _selectTime(context, _endTimeController),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown(
                      labelText: 'priority',
                      items: _priorities,
                      selectedItem: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = _priorities
                              .firstWhere((item) => item.value == value);
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Select a priority' : null,
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown(
                      labelText: 'frequency',
                      items: _frequencies,
                      selectedItem: _selectedFrequency,
                      onChanged: (value) {
                        setState(() {
                          _selectedFrequency = _frequencies
                              .firstWhere((item) => item.value == value);
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Select a frequncy' : null,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _addRule,
                      child: Text('save'.tr()),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
