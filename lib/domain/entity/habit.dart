// lib/domain/entity/habit.dart

enum HabitStatus { active, completed }

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

  // Habit → Map に変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status.name, // Enumは.name で文字列に変換
      'createdAt': createdAt.toIso8601String(), // DateTimeは文字列に変換
    };
  }

  // Map → Habit に変換(ファクトリコンストラクタ)
  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as String,
      title: json['title'] as String,
      status: HabitStatus.values.byName(
        json['status'] as String,
      ), // 文字列からEnumに変換
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
