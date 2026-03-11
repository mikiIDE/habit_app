import 'package:habit_app/domain/repository/habit_repository.dart';

class DeleteHabitUseCase {
  final HabitRepository repository;
  DeleteHabitUseCase(this.repository);

  Future<void> execute(String id) async {
    await repository.deleteHabit(id);
  }
}
