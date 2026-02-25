import 'package:habit_app/domain/entity/habit.dart';

abstract class HabitRepository {
  Future<void> addHabit(Habit habit);
  Future<List<Habit>> fetchHabits();
  Future<void> updateHabit(Habit habit);
}
