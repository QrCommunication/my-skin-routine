// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActionCompletion {

 int get actionId; String get completedDate; DateTime get completedAt;
/// Create a copy of ActionCompletion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActionCompletionCopyWith<ActionCompletion> get copyWith => _$ActionCompletionCopyWithImpl<ActionCompletion>(this as ActionCompletion, _$identity);

  /// Serializes this ActionCompletion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActionCompletion&&(identical(other.actionId, actionId) || other.actionId == actionId)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,actionId,completedDate,completedAt);

@override
String toString() {
  return 'ActionCompletion(actionId: $actionId, completedDate: $completedDate, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $ActionCompletionCopyWith<$Res>  {
  factory $ActionCompletionCopyWith(ActionCompletion value, $Res Function(ActionCompletion) _then) = _$ActionCompletionCopyWithImpl;
@useResult
$Res call({
 int actionId, String completedDate, DateTime completedAt
});




}
/// @nodoc
class _$ActionCompletionCopyWithImpl<$Res>
    implements $ActionCompletionCopyWith<$Res> {
  _$ActionCompletionCopyWithImpl(this._self, this._then);

  final ActionCompletion _self;
  final $Res Function(ActionCompletion) _then;

/// Create a copy of ActionCompletion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? actionId = null,Object? completedDate = null,Object? completedAt = null,}) {
  return _then(_self.copyWith(
actionId: null == actionId ? _self.actionId : actionId // ignore: cast_nullable_to_non_nullable
as int,completedDate: null == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ActionCompletion].
extension ActionCompletionPatterns on ActionCompletion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActionCompletion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActionCompletion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActionCompletion value)  $default,){
final _that = this;
switch (_that) {
case _ActionCompletion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActionCompletion value)?  $default,){
final _that = this;
switch (_that) {
case _ActionCompletion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int actionId,  String completedDate,  DateTime completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActionCompletion() when $default != null:
return $default(_that.actionId,_that.completedDate,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int actionId,  String completedDate,  DateTime completedAt)  $default,) {final _that = this;
switch (_that) {
case _ActionCompletion():
return $default(_that.actionId,_that.completedDate,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int actionId,  String completedDate,  DateTime completedAt)?  $default,) {final _that = this;
switch (_that) {
case _ActionCompletion() when $default != null:
return $default(_that.actionId,_that.completedDate,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActionCompletion implements ActionCompletion {
  const _ActionCompletion({required this.actionId, required this.completedDate, required this.completedAt});
  factory _ActionCompletion.fromJson(Map<String, dynamic> json) => _$ActionCompletionFromJson(json);

@override final  int actionId;
@override final  String completedDate;
@override final  DateTime completedAt;

/// Create a copy of ActionCompletion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActionCompletionCopyWith<_ActionCompletion> get copyWith => __$ActionCompletionCopyWithImpl<_ActionCompletion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActionCompletionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActionCompletion&&(identical(other.actionId, actionId) || other.actionId == actionId)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,actionId,completedDate,completedAt);

@override
String toString() {
  return 'ActionCompletion(actionId: $actionId, completedDate: $completedDate, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$ActionCompletionCopyWith<$Res> implements $ActionCompletionCopyWith<$Res> {
  factory _$ActionCompletionCopyWith(_ActionCompletion value, $Res Function(_ActionCompletion) _then) = __$ActionCompletionCopyWithImpl;
@override @useResult
$Res call({
 int actionId, String completedDate, DateTime completedAt
});




}
/// @nodoc
class __$ActionCompletionCopyWithImpl<$Res>
    implements _$ActionCompletionCopyWith<$Res> {
  __$ActionCompletionCopyWithImpl(this._self, this._then);

  final _ActionCompletion _self;
  final $Res Function(_ActionCompletion) _then;

/// Create a copy of ActionCompletion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? actionId = null,Object? completedDate = null,Object? completedAt = null,}) {
  return _then(_ActionCompletion(
actionId: null == actionId ? _self.actionId : actionId // ignore: cast_nullable_to_non_nullable
as int,completedDate: null == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
