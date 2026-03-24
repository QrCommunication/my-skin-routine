// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  brand: json['brand'] as String,
  type: $enumDecode(_$ProductTypeEnumMap, json['type']),
  photoPath: json['photoPath'] as String?,
  notes: json['notes'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brand': instance.brand,
  'type': _$ProductTypeEnumMap[instance.type]!,
  'photoPath': instance.photoPath,
  'notes': instance.notes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$ProductTypeEnumMap = {
  ProductType.cleanser: 'cleanser',
  ProductType.toner: 'toner',
  ProductType.serum: 'serum',
  ProductType.moisturizer: 'moisturizer',
  ProductType.sunscreen: 'sunscreen',
  ProductType.oil: 'oil',
  ProductType.mask: 'mask',
  ProductType.exfoliant: 'exfoliant',
  ProductType.eyeCream: 'eyeCream',
  ProductType.lipCare: 'lipCare',
  ProductType.mist: 'mist',
  ProductType.spotTreatment: 'spotTreatment',
  ProductType.other: 'other',
};
