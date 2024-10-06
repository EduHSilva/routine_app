import 'package:flutter/material.dart';
import 'package:routineapp/config/design_system.dart';
import 'package:routineapp/views/tasks/tabs/category_tab.dart';
import 'package:routineapp/views/tasks/tabs/rules_tab.dart';
import 'package:routineapp/widgets/custom_appbar.dart';
import 'package:routineapp/widgets/custom_drawer.dart';
import 'package:routineapp/config/app_config.dart';
import 'package:routineapp/viewmodels/tasks_viewmodel.dart';
import 'package:routineapp/views/tasks/tabs/all_tasks_tab.dart';
import '../../models/tasks/task_model.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  TasksViewState createState() => TasksViewState();
}

class TasksViewState extends State<TasksView> {
  bool _isLoading = false;
  final TasksViewModel _tasksViewModel = TasksViewModel();
  Map<String, List<Task>>? _tasksByDay;

  @override
  void initState() {
    super.initState();
    getWeekTasks();
  }

  Future<void> getWeekTasks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final tasks = await _tasksViewModel.getWeekTasks();
      setState(() {
        _tasksByDay = tasks;
      });
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Tasks',
          bottom: TabBar(
            labelColor: AppColors.onPrimary,
            tabs: [
              Tab(text: 'Semana'),
              Tab(text: 'Regras'),
              Tab(text: 'Categorias'),
            ],
          ),
        ),
        drawer: const CustomDrawer(currentRoute: "/tasks"),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  AllTasksTab(tasksByDay: _tasksByDay),
                  const RulesTab(),
                  const CategoryTab(),
                ],
              ),
      ),
    );
  }
}
