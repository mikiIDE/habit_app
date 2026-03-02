import 'package:flutter/material.dart';

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({super.key});

  @override
  State<HabitListScreen> createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  // ダミーデータ
  final List<String> _habits = ['運動', '読書', '瞑想'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('習慣リスト')),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(_habits[index]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: ダイアログを表示する
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
