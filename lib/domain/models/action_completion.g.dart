// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActionCompletion _$ActionCompletionFromJson(Map<String, dynamic> json) =>
    _ActionCompletion(
      actionId: (json['actionId'] as num).toInt(),
      completedDate: json['completedDate'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$ActionCompletionToJson(_ActionCompletion instance) =>
    <String, dynamic>{
      'actionId': instance.actionId,
      'completedDate': instance.completedDate,
      'completedAt': instance.completedAt.toIso8601String(),
    };
