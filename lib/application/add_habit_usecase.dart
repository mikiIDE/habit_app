import 'package:habit_app/domain/entity/habit.dart';
import 'package:habit_app/domain/repository/habit_repository.dart';

class AddHabitUseCase {
  final HabitRepository repository;

  AddHabitUseCase(this.repository);

  Future<void> execute(String title) async {
    // ① 空タイトルチェック（titleが空なら例外を投げる）
    if (title.isEmpty) {
      throw Exception('タイトルは空にできません');
    }

    // ② Habitオブジェクトを生成（id, title, createdAtを設定）
    final habit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ユニークなIDを生成
      title: title,
      createdAt: DateTime.now(),
    );

    // ③ repository.addHabit() を呼ぶ
    await repository.addHabit(habit);
  }
}
