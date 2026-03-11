import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_app/provider/habit_list_notifier.dart';
import 'package:habit_app/domain/entity/habit.dart';

class HabitListScreen extends ConsumerWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Notifierから習慣リストを取得（変更があれば自動で再描画）
    final habits = ref.watch(habitListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('習慣リスト')),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return ListTile(
            title: Text(
              habit.title,
              style: habit.status == HabitStatus.completed
                  ? TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    )
                  : null,
            ),
            // チェックボタンで完了にする
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    ref.read(habitListProvider.notifier).completeHabit(habit);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(habitListProvider.notifier).deleteHabit(habit.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  // 追加ダイアログ
  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
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
                  // Notifier経由でUseCaseを呼ぶ
                  ref.read(habitListProvider.notifier).addHabit(title);
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
}
