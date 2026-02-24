// lib/domain/entity/habit.dart

enum HabitStatus {
  active,
  completed,
}

// クラス定義とフィールド
class Habit {
  final String id;
  final String title;
  final HabitStatus status;
  final DateTime createdAt;

// コンストラクタ
  Habit({
    required this.id,
    required this.title,
    this.status = HabitStatus.active,
    required this.createdAt,
  });
}
