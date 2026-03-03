import 'package:flutter/material.dart';

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({super.key});

  @override
  State<HabitListScreen> createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  // ダミーデータ
  final List<String> _habits = ['運動', '読書', '瞑想'];
  void _showAddHabitDialog() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('習慣を追加'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: '習慣のタイトルを入力'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                final title = textController.text;
                if (title.isNotEmpty) {
                  setState(() {
                    _habits.add(title);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  }

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
        onPressed: _showAddHabitDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
