import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_app/domain/entity/habit.dart';
import 'package:habit_app/provider/habit_usecase_providers.dart';

// 習慣リストの状態を管理するNotifier
class HabitListNotifier extends Notifier<List<Habit>> {
  @override
  List<Habit> build() => []; // 初期状態は空リスト

  // 習慣を追加して、一覧を再取得
  Future<void> addHabit(String title) async {
    await ref.read(addHabitUseCaseProvider).execute(title);
    await fetchHabits();
  }

  // 一覧を取得して、状態を更新
  Future<void> fetchHabits() async {
    state = await ref.read(fetchHabitUseCaseProvider).execute();
  }

  // 習慣を完了にして、一覧を再取得
  Future<void> completeHabit(Habit habit) async {
    await ref.read(completeHabitUseCaseProvider).execute(habit);
    await fetchHabits();
  }
}

// UIから使うためのProvider
final habitListProvider =
    NotifierProvider<HabitListNotifier, List<Habit>>(
  HabitListNotifier.new,
);
