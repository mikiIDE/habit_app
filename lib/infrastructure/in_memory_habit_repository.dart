import 'package:habit_app/domain/entity/habit.dart';
import 'package:habit_app/domain/repository/habit_repository.dart';

class InMemoryHabitRepository implements HabitRepository {
  final List<Habit> _habits = [];

  @override
  Future<void> addHabit(Habit habit) async {
    _habits.add(habit);
  }

  @override
  Future<List<Habit>> fetchHabits() async {
    return _habits;
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final index = _habits.indexWhere((h) => h.id == habit.id);
    _habits[index] = habit;
  }
}
