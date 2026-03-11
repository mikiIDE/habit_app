import 'dart:convert';
import 'package:habit_app/domain/entity/habit.dart';
import 'package:habit_app/domain/repository/habit_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHabitRepository implements HabitRepository {
  // 'habits' というキー名でJSON文字列をまとめて保存する
  static const _key = 'habits';

  @override
  Future<List<Habit>> fetchHabits() async {
    // 流れ：JSON文字列 → jsonDecode → List<Map> → fromJson → List<Habit>
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key); // 文字列を取得
    if (jsonString == null) return []; // 初回は何もないため空リストを返す
    final List<dynamic> jsonList = jsonDecode(jsonString); // 文字列をListに変換
    // 各MapをHabitオブジェクトに変換してリストで返す
    return jsonList
        .map((e) => Habit.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addHabit(Habit habit) async {
    final habits = await fetchHabits(); // 既存データを全て読み込む
    habits.add(habit); // 追加
    await _save(habits); // 全件上書き（SharedPreferencesは個別のアイテム更新ができないため）
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final habits = await fetchHabits();
    final index = habits.indexWhere((h) => h.id == habit.id); // idが一致するものを探す
    // 該当indexの要素を新しいHabitで上書き
    habits[index] = habit;
    await _save(habits);
  }

  Future<void> _save(List<Habit> habits) async {
    final prefs = await SharedPreferences.getInstance();
    // List<Habit> → toJson → List<Map> → jsonEncode → JSON文字列
    final jsonString = jsonEncode(habits.map((h) => h.toJson()).toList());
    await prefs.setString(_key, jsonString); // SharedPreferencesに保存
  }

  @override
  Future<void> deleteHabit(String id) async {
    final habits = await fetchHabits(); // 全件取得
    habits.removeWhere((h) => h.id == id); // idが一致するものを削除
    await _save(habits); // 全件上書き
  }
}
