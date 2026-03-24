// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skin_journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkinJournalEntry _$SkinJournalEntryFromJson(Map<String, dynamic> json) =>
    _SkinJournalEntry(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
      photoPath: json['photoPath'] as String?,
      notes: json['notes'] as String,
      skinFeeling: (json['skinFeeling'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SkinJournalEntryToJson(_SkinJournalEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'photoPath': instance.photoPath,
      'notes': instance.notes,
      'skinFeeling': instance.skinFeeling,
      'createdAt': instance.createdAt.toIso8601String(),
    };
