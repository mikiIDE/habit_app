// CompleteHabitUseCase.dart
import 'package:habit_app/domain/entity/habit.dart';
import 'package:habit_app/domain/repository/habit_repository.dart';

class CompleteHabitUseCase {
  final HabitRepository repository;
  CompleteHabitUseCase(this.repository);

  Future<void> execute(Habit habit) async {
    final updateHabit = Habit( // statusだけ変えたHabitを新しく作る
      id: habit.id,
      title: habit.title,
      status: HabitStatus.completed,
      createdAt: habit.createdAt,
    );
    await repository.updateHabit(updateHabit); // 上書き保存
  }
}
