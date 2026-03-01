// FetchHabitUseCase.dart
import 'package:habit_app/domain/entity/habit.dart';
import 'package:habit_app/domain/repository/habit_repository.dart';

class FetchHabitUseCase {
  // ① HabitRepositoryを受け取るコンストラクタ
  // HabitRepositoryという型の、repositoryという変数を定義（何を使って仕事をするのか？を定義）
  final HabitRepository repository;
  // ② コンストラクタ(同じ)
  // this.repository = 外から渡されたものを、さっき宣言した変数repositoryに代入するという意味
  FetchHabitUseCase(this.repository);

  // ③ executeというメソッド「このUseCaseを実行する」という意味
  Future<List<Habit>> execute() async {
    // ④ repositoryから取得して返すだけ
    return await repository.fetchHabits();
  }
}
