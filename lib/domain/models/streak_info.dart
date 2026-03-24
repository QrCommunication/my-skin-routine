import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_info.freezed.dart';

@freezed
abstract class StreakInfo with _$StreakInfo {
  const factory StreakInfo({
    required int routineId,
    required String routineName,
    required int currentStreak,
    required int bestStreak,
  }) = _StreakInfo;
}
