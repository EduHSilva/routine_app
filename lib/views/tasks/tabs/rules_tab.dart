import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:routineapp/config/app_config.dart';
import 'package:routineapp/config/helper.dart';
import 'package:routineapp/models/tasks/task_model.dart';
import 'package:routineapp/views/tasks/new_task_view.dart';

import '../../../viewmodels/tasks_viewmodel.dart';
import '../../../widgets/custom_modal_input.dart';



class RulesTab extends StatefulWidget {
  const RulesTab({super.key});

  @override
  RulesTabState createState() => RulesTabState();
}

class RulesTabState extends State<RulesTab> {
  final TasksViewModel _tasksViewModel = TasksViewModel();
  List<Task> _tasks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getRules();
    });
  }

  void _getRules() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Task> response = await _tasksViewModel.getRules();

      setState(() {
        _tasks = response;
      });
    } catch (e) {
      AppConfig.getLogger().e(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addRule(String title) async {
    // TODO: Implementar lógica para adicionar uma nova regra
  }

  void _deleteRule(int id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      TaskResponse? response = await _tasksViewModel.deleteRule(id);
      if (response?.task != null) {
        _getRules();
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
        title: Text('rules'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewTaskView(),
                ),
              );
            },
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? Center(child: Text('noData'.tr()))
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];

          return Card(
            margin: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(task.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: ${task.category}'),
                  Text('Priority: ${task.priority}'),
                  Text('Frequency: ${task.frequency}'),
                  Text('Start: ${task.dateStart} - ${task.startTime}'),
                  Text('End: ${task.dateEnd} - ${task.endTime}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editRuleDialog(task);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteRuleDialog(task);
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

  void _editRuleDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomModalInput(
          title: 'editRule',
          hintTexts: const ['title'],
          initialValues: {'title': task.title},
          onConfirm: (values) {
            // Implementar lógica para editar regra
          },
          isForm: true,
        );
      },
    );
  }

  void _deleteRuleDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomModalInput(
          title: "attention",
          hintTexts: const ['confirmDelete'],
          onConfirm: (_) {
            _deleteRule(task.id);
          },
          isWarn: true,
        );
      },
    );
  }
}
