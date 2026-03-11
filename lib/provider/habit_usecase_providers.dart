import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_app/application/add_habit_usecase.dart';
import 'package:habit_app/application/delete_habit_usecase.dart';
import 'package:habit_app/application/fetch_habit_usecase.dart';
import 'package:habit_app/application/complete_habit_usecase.dart';
import 'package:habit_app/provider/habit_repository_provider.dart';

// ref.watch(habitRepositoryProvider) で「共有された1つのRepository」をもらう
final addHabitUseCaseProvider = Provider<AddHabitUseCase>((ref) {
  return AddHabitUseCase(ref.watch(habitRepositoryProvider));
});

final fetchHabitUseCaseProvider = Provider<FetchHabitUseCase>((ref) {
  return FetchHabitUseCase(ref.watch(habitRepositoryProvider));
});

final completeHabitUseCaseProvider = Provider<CompleteHabitUseCase>((ref) {
  return CompleteHabitUseCase(ref.watch(habitRepositoryProvider));
});

final deleteHabitUseCaseProvider = Provider<DeleteHabitUseCase>((ref) {
  return DeleteHabitUseCase(ref.watch(habitRepositoryProvider));
});
