// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoutineAction {

 int get id; int get routineId; int? get productId; String get name; String? get description; int get sortOrder; RecurrenceType get recurrenceType; int get recurrenceInterval; String get recurrenceStartDate; DateTime get createdAt; Product? get product;
/// Create a copy of RoutineAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineActionCopyWith<RoutineAction> get copyWith => _$RoutineActionCopyWithImpl<RoutineAction>(this as RoutineAction, _$identity);

  /// Serializes this RoutineAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineAction&&(identical(other.id, id) || other.id == id)&&(identical(other.routineId, routineId) || other.routineId == routineId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.recurrenceType, recurrenceType) || other.recurrenceType == recurrenceType)&&(identical(other.recurrenceInterval, recurrenceInterval) || other.recurrenceInterval == recurrenceInterval)&&(identical(other.recurrenceStartDate, recurrenceStartDate) || other.recurrenceStartDate == recurrenceStartDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.product, product) || other.product == product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,routineId,productId,name,description,sortOrder,recurrenceType,recurrenceInterval,recurrenceStartDate,createdAt,product);

@override
String toString() {
  return 'RoutineAction(id: $id, routineId: $routineId, productId: $productId, name: $name, description: $description, sortOrder: $sortOrder, recurrenceType: $recurrenceType, recurrenceInterval: $recurrenceInterval, recurrenceStartDate: $recurrenceStartDate, createdAt: $createdAt, product: $product)';
}


}

/// @nodoc
abstract mixin class $RoutineActionCopyWith<$Res>  {
  factory $RoutineActionCopyWith(RoutineAction value, $Res Function(RoutineAction) _then) = _$RoutineActionCopyWithImpl;
@useResult
$Res call({
 int id, int routineId, int? productId, String name, String? description, int sortOrder, RecurrenceType recurrenceType, int recurrenceInterval, String recurrenceStartDate, DateTime createdAt, Product? product
});


$ProductCopyWith<$Res>? get product;

}
/// @nodoc
class _$RoutineActionCopyWithImpl<$Res>
    implements $RoutineActionCopyWith<$Res> {
  _$RoutineActionCopyWithImpl(this._self, this._then);

  final RoutineAction _self;
  final $Res Function(RoutineAction) _then;

/// Create a copy of RoutineAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? routineId = null,Object? productId = freezed,Object? name = null,Object? description = freezed,Object? sortOrder = null,Object? recurrenceType = null,Object? recurrenceInterval = null,Object? recurrenceStartDate = null,Object? createdAt = null,Object? product = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,routineId: null == routineId ? _self.routineId : routineId // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,recurrenceType: null == recurrenceType ? _self.recurrenceType : recurrenceType // ignore: cast_nullable_to_non_nullable
as RecurrenceType,recurrenceInterval: null == recurrenceInterval ? _self.recurrenceInterval : recurrenceInterval // ignore: cast_nullable_to_non_nullable
as int,recurrenceStartDate: null == recurrenceStartDate ? _self.recurrenceStartDate : recurrenceStartDate // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product?,
  ));
}
/// Create a copy of RoutineAction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $ProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoutineAction].
extension RoutineActionPatterns on RoutineAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineAction value)  $default,){
final _that = this;
switch (_that) {
case _RoutineAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineAction value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int routineId,  int? productId,  String name,  String? description,  int sortOrder,  RecurrenceType recurrenceType,  int recurrenceInterval,  String recurrenceStartDate,  DateTime createdAt,  Product? product)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineAction() when $default != null:
return $default(_that.id,_that.routineId,_that.productId,_that.name,_that.description,_that.sortOrder,_that.recurrenceType,_that.recurrenceInterval,_that.recurrenceStartDate,_that.createdAt,_that.product);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int routineId,  int? productId,  String name,  String? description,  int sortOrder,  RecurrenceType recurrenceType,  int recurrenceInterval,  String recurrenceStartDate,  DateTime createdAt,  Product? product)  $default,) {final _that = this;
switch (_that) {
case _RoutineAction():
return $default(_that.id,_that.routineId,_that.productId,_that.name,_that.description,_that.sortOrder,_that.recurrenceType,_that.recurrenceInterval,_that.recurrenceStartDate,_that.createdAt,_that.product);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int routineId,  int? productId,  String name,  String? description,  int sortOrder,  RecurrenceType recurrenceType,  int recurrenceInterval,  String recurrenceStartDate,  DateTime createdAt,  Product? product)?  $default,) {final _that = this;
switch (_that) {
case _RoutineAction() when $default != null:
return $default(_that.id,_that.routineId,_that.productId,_that.name,_that.description,_that.sortOrder,_that.recurrenceType,_that.recurrenceInterval,_that.recurrenceStartDate,_that.createdAt,_that.product);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutineAction implements RoutineAction {
  const _RoutineAction({required this.id, required this.routineId, this.productId, required this.name, this.description, required this.sortOrder, this.recurrenceType = RecurrenceType.daily, this.recurrenceInterval = 1, required this.recurrenceStartDate, required this.createdAt, this.product});
  factory _RoutineAction.fromJson(Map<String, dynamic> json) => _$RoutineActionFromJson(json);

@override final  int id;
@override final  int routineId;
@override final  int? productId;
@override final  String name;
@override final  String? description;
@override final  int sortOrder;
@override@JsonKey() final  RecurrenceType recurrenceType;
@override@JsonKey() final  int recurrenceInterval;
@override final  String recurrenceStartDate;
@override final  DateTime createdAt;
@override final  Product? product;

/// Create a copy of RoutineAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineActionCopyWith<_RoutineAction> get copyWith => __$RoutineActionCopyWithImpl<_RoutineAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineAction&&(identical(other.id, id) || other.id == id)&&(identical(other.routineId, routineId) || other.routineId == routineId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.recurrenceType, recurrenceType) || other.recurrenceType == recurrenceType)&&(identical(other.recurrenceInterval, recurrenceInterval) || other.recurrenceInterval == recurrenceInterval)&&(identical(other.recurrenceStartDate, recurrenceStartDate) || other.recurrenceStartDate == recurrenceStartDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.product, product) || other.product == product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,routineId,productId,name,description,sortOrder,recurrenceType,recurrenceInterval,recurrenceStartDate,createdAt,product);

@override
String toString() {
  return 'RoutineAction(id: $id, routineId: $routineId, productId: $productId, name: $name, description: $description, sortOrder: $sortOrder, recurrenceType: $recurrenceType, recurrenceInterval: $recurrenceInterval, recurrenceStartDate: $recurrenceStartDate, createdAt: $createdAt, product: $product)';
}


}

/// @nodoc
abstract mixin class _$RoutineActionCopyWith<$Res> implements $RoutineActionCopyWith<$Res> {
  factory _$RoutineActionCopyWith(_RoutineAction value, $Res Function(_RoutineAction) _then) = __$RoutineActionCopyWithImpl;
@override @useResult
$Res call({
 int id, int routineId, int? productId, String name, String? description, int sortOrder, RecurrenceType recurrenceType, int recurrenceInterval, String recurrenceStartDate, DateTime createdAt, Product? product
});


@override $ProductCopyWith<$Res>? get product;

}
/// @nodoc
class __$RoutineActionCopyWithImpl<$Res>
    implements _$RoutineActionCopyWith<$Res> {
  __$RoutineActionCopyWithImpl(this._self, this._then);

  final _RoutineAction _self;
  final $Res Function(_RoutineAction) _then;

/// Create a copy of RoutineAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routineId = null,Object? productId = freezed,Object? name = null,Object? description = freezed,Object? sortOrder = null,Object? recurrenceType = null,Object? recurrenceInterval = null,Object? recurrenceStartDate = null,Object? createdAt = null,Object? product = freezed,}) {
  return _then(_RoutineAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,routineId: null == routineId ? _self.routineId : routineId // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,recurrenceType: null == recurrenceType ? _self.recurrenceType : recurrenceType // ignore: cast_nullable_to_non_nullable
as RecurrenceType,recurrenceInterval: null == recurrenceInterval ? _self.recurrenceInterval : recurrenceInterval // ignore: cast_nullable_to_non_nullable
as int,recurrenceStartDate: null == recurrenceStartDate ? _self.recurrenceStartDate : recurrenceStartDate // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product?,
  ));
}

/// Create a copy of RoutineAction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $ProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

// dart format on
