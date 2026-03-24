import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_skin_routine/core/constants/enums.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    required String brand,
    required ProductType type,
    String? photoPath,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
