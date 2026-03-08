import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_app/domain/repository/habit_repository.dart';
import 'package:habit_app/infrastructure/shared_preferences_habit_repository.dart';

// アプリ全体で1つのRepositoryインスタンスを共有する
// もし各UseCaseが独自のRepositoryを使っていると、別物のためaddしたものがfetchできない
final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return SharedPreferencesHabitRepository();
});
