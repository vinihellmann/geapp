import 'dart:convert';

import 'package:uuid/uuid.dart';

class UnitModel {
  int? id;
  String? code;
  String? productCode;
  String? unit;
  double? stock;
  double? price;
  String createdAt;
  String updatedAt;

  UnitModel({
    this.id,
    this.code,
    this.productCode,
    this.unit,
    this.stock,
    this.price,
    String? createdAt,
    String? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  UnitModel copyWith({
    int? id,
    String? code,
    String? productCode,
    String? unit,
    double? stock,
    double? price,
    String? createdAt,
    String? updatedAt,
  }) {
    return UnitModel(
      id: id ?? this.id,
      code: code ?? this.code,
      productCode: productCode ?? this.productCode,
      unit: unit ?? this.unit,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    var uuid = const Uuid();
    String uniqueCode = code ?? uuid.v4();

    return <String, dynamic>{
      'code': uniqueCode,
      'productCode': productCode,
      'unit': unit,
      'stock': stock,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      productCode:
          map['productCode'] != null ? map['productCode'] as String : null,
      unit: map['unit'] != null ? map['unit'] as String : null,
      stock: map['stock'] != null ? map['stock'] as double : null,
      price: map['price'] != null ? map['price'] as double : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnitModel.fromJson(String source) =>
      UnitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UnitModel(id: $id, code: $code, productCode: $productCode, unit: $unit, stock: $stock, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UnitModel other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.productCode == productCode &&
        other.unit == unit &&
        other.stock == stock &&
        other.price == price &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        productCode.hashCode ^
        unit.hashCode ^
        stock.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
