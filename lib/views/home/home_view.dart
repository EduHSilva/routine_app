import 'package:flutter/material.dart';
import 'package:routineapp/widgets/custom_appbar.dart';
import 'package:routineapp/widgets/custom_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      drawer: CustomDrawer(currentRoute: '/home'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Box
            TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                // Lógica de busca pode ser adicionada aqui
              },
            ),
            const SizedBox(height: 20),
            // Search Results Section
            const Text(
              'Resultados da Busca:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // exemplo: quantidade de resultados da busca
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.task_alt),
                    title: Text('Resultado $index'),
                    subtitle: const Text('Descrição do resultado.'),
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            // Pending Tasks Section
            const Text(
              'Tarefas Pendentes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2, // Exemplo: número de tarefas pendentes
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.check_box_outline_blank),
                      title: Text('Tarefa Pendente $index'),
                      subtitle: const Text('Descrição da tarefa pendente.'),
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            // Next Meal Section
            const Text(
              'Próxima Refeição:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text('Refeição: Almoço'),
                subtitle: Text('Horário: 12:30 PM'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
