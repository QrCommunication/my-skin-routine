import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/domain/models/routine_action.dart';

part 'routine.freezed.dart';
part 'routine.g.dart';

@freezed
abstract class Routine with _$Routine {
  const factory Routine({
    required int id,
    required String name,
    String? description,
    required BodyZone bodyZone,
    required SkinGoal skinGoal,
    String? reminderTime,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<RoutineAction> actions,
  }) = _Routine;

  factory Routine.fromJson(Map<String, dynamic> json) => _$RoutineFromJson(json);
}
