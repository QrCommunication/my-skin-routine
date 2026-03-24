import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/domain/models/product.dart';

part 'routine_action.freezed.dart';
part 'routine_action.g.dart';

@freezed
abstract class RoutineAction with _$RoutineAction {
  const factory RoutineAction({
    required int id,
    required int routineId,
    int? productId,
    required String name,
    String? description,
    required int sortOrder,
    @Default(RecurrenceType.daily) RecurrenceType recurrenceType,
    @Default(1) int recurrenceInterval,
    required String recurrenceStartDate,
    required DateTime createdAt,
    Product? product,
  }) = _RoutineAction;

  factory RoutineAction.fromJson(Map<String, dynamic> json) => _$RoutineActionFromJson(json);
}
