import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_completion.freezed.dart';
part 'action_completion.g.dart';

@freezed
abstract class ActionCompletion with _$ActionCompletion {
  const factory ActionCompletion({
    required int actionId,
    required String completedDate,
    required DateTime completedAt,
  }) = _ActionCompletion;

  factory ActionCompletion.fromJson(Map<String, dynamic> json) => _$ActionCompletionFromJson(json);
}
