// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Routine _$RoutineFromJson(Map<String, dynamic> json) => _Routine(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  bodyZone: $enumDecode(_$BodyZoneEnumMap, json['bodyZone']),
  skinGoal: $enumDecode(_$SkinGoalEnumMap, json['skinGoal']),
  reminderTime: json['reminderTime'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  actions:
      (json['actions'] as List<dynamic>?)
          ?.map((e) => RoutineAction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$RoutineToJson(_Routine instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'bodyZone': _$BodyZoneEnumMap[instance.bodyZone]!,
  'skinGoal': _$SkinGoalEnumMap[instance.skinGoal]!,
  'reminderTime': instance.reminderTime,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'actions': instance.actions,
};

const _$BodyZoneEnumMap = {
  BodyZone.fullFace: 'fullFace',
  BodyZone.forehead: 'forehead',
  BodyZone.cheeks: 'cheeks',
  BodyZone.nose: 'nose',
  BodyZone.chin: 'chin',
  BodyZone.eyes: 'eyes',
  BodyZone.lips: 'lips',
  BodyZone.neck: 'neck',
  BodyZone.decollete: 'decollete',
  BodyZone.hands: 'hands',
  BodyZone.body: 'body',
  BodyZone.other: 'other',
};

const _$SkinGoalEnumMap = {
  SkinGoal.hydration: 'hydration',
  SkinGoal.antiAging: 'antiAging',
  SkinGoal.acne: 'acne',
  SkinGoal.brightening: 'brightening',
  SkinGoal.soothing: 'soothing',
  SkinGoal.firming: 'firming',
  SkinGoal.poreCare: 'poreCare',
  SkinGoal.darkSpots: 'darkSpots',
  SkinGoal.sensitive: 'sensitive',
  SkinGoal.general: 'general',
};
