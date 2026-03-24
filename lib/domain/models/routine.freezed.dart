// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Routine {

 int get id; String get name; String? get description; BodyZone get bodyZone; SkinGoal get skinGoal; String? get reminderTime; bool get isActive; DateTime get createdAt; DateTime get updatedAt; List<RoutineAction> get actions;
/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineCopyWith<Routine> get copyWith => _$RoutineCopyWithImpl<Routine>(this as Routine, _$identity);

  /// Serializes this Routine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Routine&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.bodyZone, bodyZone) || other.bodyZone == bodyZone)&&(identical(other.skinGoal, skinGoal) || other.skinGoal == skinGoal)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.actions, actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,bodyZone,skinGoal,reminderTime,isActive,createdAt,updatedAt,const DeepCollectionEquality().hash(actions));

@override
String toString() {
  return 'Routine(id: $id, name: $name, description: $description, bodyZone: $bodyZone, skinGoal: $skinGoal, reminderTime: $reminderTime, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, actions: $actions)';
}


}

/// @nodoc
abstract mixin class $RoutineCopyWith<$Res>  {
  factory $RoutineCopyWith(Routine value, $Res Function(Routine) _then) = _$RoutineCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, BodyZone bodyZone, SkinGoal skinGoal, String? reminderTime, bool isActive, DateTime createdAt, DateTime updatedAt, List<RoutineAction> actions
});




}
/// @nodoc
class _$RoutineCopyWithImpl<$Res>
    implements $RoutineCopyWith<$Res> {
  _$RoutineCopyWithImpl(this._self, this._then);

  final Routine _self;
  final $Res Function(Routine) _then;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? bodyZone = null,Object? skinGoal = null,Object? reminderTime = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? actions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bodyZone: null == bodyZone ? _self.bodyZone : bodyZone // ignore: cast_nullable_to_non_nullable
as BodyZone,skinGoal: null == skinGoal ? _self.skinGoal : skinGoal // ignore: cast_nullable_to_non_nullable
as SkinGoal,reminderTime: freezed == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<RoutineAction>,
  ));
}

}


/// Adds pattern-matching-related methods to [Routine].
extension RoutinePatterns on Routine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Routine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Routine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Routine value)  $default,){
final _that = this;
switch (_that) {
case _Routine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Routine value)?  $default,){
final _that = this;
switch (_that) {
case _Routine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  BodyZone bodyZone,  SkinGoal skinGoal,  String? reminderTime,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<RoutineAction> actions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Routine() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.bodyZone,_that.skinGoal,_that.reminderTime,_that.isActive,_that.createdAt,_that.updatedAt,_that.actions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  BodyZone bodyZone,  SkinGoal skinGoal,  String? reminderTime,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<RoutineAction> actions)  $default,) {final _that = this;
switch (_that) {
case _Routine():
return $default(_that.id,_that.name,_that.description,_that.bodyZone,_that.skinGoal,_that.reminderTime,_that.isActive,_that.createdAt,_that.updatedAt,_that.actions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  BodyZone bodyZone,  SkinGoal skinGoal,  String? reminderTime,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  List<RoutineAction> actions)?  $default,) {final _that = this;
switch (_that) {
case _Routine() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.bodyZone,_that.skinGoal,_that.reminderTime,_that.isActive,_that.createdAt,_that.updatedAt,_that.actions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Routine implements Routine {
  const _Routine({required this.id, required this.name, this.description, required this.bodyZone, required this.skinGoal, this.reminderTime, this.isActive = true, required this.createdAt, required this.updatedAt, final  List<RoutineAction> actions = const []}): _actions = actions;
  factory _Routine.fromJson(Map<String, dynamic> json) => _$RoutineFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  BodyZone bodyZone;
@override final  SkinGoal skinGoal;
@override final  String? reminderTime;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<RoutineAction> _actions;
@override@JsonKey() List<RoutineAction> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}


/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineCopyWith<_Routine> get copyWith => __$RoutineCopyWithImpl<_Routine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Routine&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.bodyZone, bodyZone) || other.bodyZone == bodyZone)&&(identical(other.skinGoal, skinGoal) || other.skinGoal == skinGoal)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._actions, _actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,bodyZone,skinGoal,reminderTime,isActive,createdAt,updatedAt,const DeepCollectionEquality().hash(_actions));

@override
String toString() {
  return 'Routine(id: $id, name: $name, description: $description, bodyZone: $bodyZone, skinGoal: $skinGoal, reminderTime: $reminderTime, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, actions: $actions)';
}


}

/// @nodoc
abstract mixin class _$RoutineCopyWith<$Res> implements $RoutineCopyWith<$Res> {
  factory _$RoutineCopyWith(_Routine value, $Res Function(_Routine) _then) = __$RoutineCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, BodyZone bodyZone, SkinGoal skinGoal, String? reminderTime, bool isActive, DateTime createdAt, DateTime updatedAt, List<RoutineAction> actions
});




}
/// @nodoc
class __$RoutineCopyWithImpl<$Res>
    implements _$RoutineCopyWith<$Res> {
  __$RoutineCopyWithImpl(this._self, this._then);

  final _Routine _self;
  final $Res Function(_Routine) _then;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? bodyZone = null,Object? skinGoal = null,Object? reminderTime = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? actions = null,}) {
  return _then(_Routine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bodyZone: null == bodyZone ? _self.bodyZone : bodyZone // ignore: cast_nullable_to_non_nullable
as BodyZone,skinGoal: null == skinGoal ? _self.skinGoal : skinGoal // ignore: cast_nullable_to_non_nullable
as SkinGoal,reminderTime: freezed == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<RoutineAction>,
  ));
}


}

// dart format on
