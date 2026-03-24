// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoutineAction _$RoutineActionFromJson(Map<String, dynamic> json) =>
    _RoutineAction(
      id: (json['id'] as num).toInt(),
      routineId: (json['routineId'] as num).toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      sortOrder: (json['sortOrder'] as num).toInt(),
      recurrenceType:
          $enumDecodeNullable(
            _$RecurrenceTypeEnumMap,
            json['recurrenceType'],
          ) ??
          RecurrenceType.daily,
      recurrenceInterval: (json['recurrenceInterval'] as num?)?.toInt() ?? 1,
      recurrenceStartDate: json['recurrenceStartDate'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoutineActionToJson(_RoutineAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routineId': instance.routineId,
      'productId': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'sortOrder': instance.sortOrder,
      'recurrenceType': _$RecurrenceTypeEnumMap[instance.recurrenceType]!,
      'recurrenceInterval': instance.recurrenceInterval,
      'recurrenceStartDate': instance.recurrenceStartDate,
      'createdAt': instance.createdAt.toIso8601String(),
      'product': instance.product,
    };

const _$RecurrenceTypeEnumMap = {
  RecurrenceType.daily: 'daily',
  RecurrenceType.everyNDays: 'everyNDays',
};
