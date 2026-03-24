// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skin_journal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SkinJournalEntry {

 int get id; String get date; String? get photoPath; String get notes; int get skinFeeling; DateTime get createdAt;
/// Create a copy of SkinJournalEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkinJournalEntryCopyWith<SkinJournalEntry> get copyWith => _$SkinJournalEntryCopyWithImpl<SkinJournalEntry>(this as SkinJournalEntry, _$identity);

  /// Serializes this SkinJournalEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkinJournalEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.skinFeeling, skinFeeling) || other.skinFeeling == skinFeeling)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,photoPath,notes,skinFeeling,createdAt);

@override
String toString() {
  return 'SkinJournalEntry(id: $id, date: $date, photoPath: $photoPath, notes: $notes, skinFeeling: $skinFeeling, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SkinJournalEntryCopyWith<$Res>  {
  factory $SkinJournalEntryCopyWith(SkinJournalEntry value, $Res Function(SkinJournalEntry) _then) = _$SkinJournalEntryCopyWithImpl;
@useResult
$Res call({
 int id, String date, String? photoPath, String notes, int skinFeeling, DateTime createdAt
});




}
/// @nodoc
class _$SkinJournalEntryCopyWithImpl<$Res>
    implements $SkinJournalEntryCopyWith<$Res> {
  _$SkinJournalEntryCopyWithImpl(this._self, this._then);

  final SkinJournalEntry _self;
  final $Res Function(SkinJournalEntry) _then;

/// Create a copy of SkinJournalEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? photoPath = freezed,Object? notes = null,Object? skinFeeling = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,skinFeeling: null == skinFeeling ? _self.skinFeeling : skinFeeling // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SkinJournalEntry].
extension SkinJournalEntryPatterns on SkinJournalEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkinJournalEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkinJournalEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkinJournalEntry value)  $default,){
final _that = this;
switch (_that) {
case _SkinJournalEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkinJournalEntry value)?  $default,){
final _that = this;
switch (_that) {
case _SkinJournalEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String date,  String? photoPath,  String notes,  int skinFeeling,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkinJournalEntry() when $default != null:
return $default(_that.id,_that.date,_that.photoPath,_that.notes,_that.skinFeeling,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String date,  String? photoPath,  String notes,  int skinFeeling,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SkinJournalEntry():
return $default(_that.id,_that.date,_that.photoPath,_that.notes,_that.skinFeeling,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String date,  String? photoPath,  String notes,  int skinFeeling,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SkinJournalEntry() when $default != null:
return $default(_that.id,_that.date,_that.photoPath,_that.notes,_that.skinFeeling,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkinJournalEntry implements SkinJournalEntry {
  const _SkinJournalEntry({required this.id, required this.date, this.photoPath, required this.notes, required this.skinFeeling, required this.createdAt});
  factory _SkinJournalEntry.fromJson(Map<String, dynamic> json) => _$SkinJournalEntryFromJson(json);

@override final  int id;
@override final  String date;
@override final  String? photoPath;
@override final  String notes;
@override final  int skinFeeling;
@override final  DateTime createdAt;

/// Create a copy of SkinJournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkinJournalEntryCopyWith<_SkinJournalEntry> get copyWith => __$SkinJournalEntryCopyWithImpl<_SkinJournalEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkinJournalEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkinJournalEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.skinFeeling, skinFeeling) || other.skinFeeling == skinFeeling)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,photoPath,notes,skinFeeling,createdAt);

@override
String toString() {
  return 'SkinJournalEntry(id: $id, date: $date, photoPath: $photoPath, notes: $notes, skinFeeling: $skinFeeling, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SkinJournalEntryCopyWith<$Res> implements $SkinJournalEntryCopyWith<$Res> {
  factory _$SkinJournalEntryCopyWith(_SkinJournalEntry value, $Res Function(_SkinJournalEntry) _then) = __$SkinJournalEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, String date, String? photoPath, String notes, int skinFeeling, DateTime createdAt
});




}
/// @nodoc
class __$SkinJournalEntryCopyWithImpl<$Res>
    implements _$SkinJournalEntryCopyWith<$Res> {
  __$SkinJournalEntryCopyWithImpl(this._self, this._then);

  final _SkinJournalEntry _self;
  final $Res Function(_SkinJournalEntry) _then;

/// Create a copy of SkinJournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? photoPath = freezed,Object? notes = null,Object? skinFeeling = null,Object? createdAt = null,}) {
  return _then(_SkinJournalEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,skinFeeling: null == skinFeeling ? _self.skinFeeling : skinFeeling // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
