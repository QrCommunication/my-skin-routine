import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:my_skin_routine/data/repositories/routine_repository_impl.dart';
import 'package:my_skin_routine/domain/models/action_completion.dart';
import 'package:my_skin_routine/domain/models/routine.dart';
import 'package:my_skin_routine/domain/models/routine_action.dart';
import 'package:my_skin_routine/domain/repositories/routine_repository.dart';
import 'package:my_skin_routine/presentation/providers/database_provider.dart';

part 'routine_providers.g.dart';

@riverpod
RoutineRepository routineRepository(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return RoutineRepositoryImpl(database);
}

/// Reactive stream — auto-updates when DB changes
@riverpod
Stream<List<Routine>> routineList(Ref ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return repository.watchAllRoutines();
}

@riverpod
Stream<List<Routine>> activeRoutines(Ref ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return repository.watchActiveRoutines();
}

@riverpod
Future<Routine?> routineById(Ref ref, int id) async {
  final repository = ref.watch(routineRepositoryProvider);
  return repository.getRoutineById(id);
}

@riverpod
Stream<List<RoutineAction>> routineActions(Ref ref, int routineId) {
  final repository = ref.watch(routineRepositoryProvider);
  return repository.watchActionsForRoutine(routineId);
}

@riverpod
Stream<List<ActionCompletion>> completionsForDate(Ref ref, String date) {
  final repository = ref.watch(routineRepositoryProvider);
  return repository.watchCompletionsForDate(date);
}
