import 'dart:convert';

import 'package:uuid/uuid.dart';

class SaleItemModel {
  int? id;
  String? code;
  String? saleCode;
  String? productCode;
  String? productName;
  String? unitCode;
  String? unitName;
  double? unitValue;
  double? quantity;
  double? discountValue;
  double? discountPercentage;
  double? finalValue;
  double? totalValue;
  String createdAt;
  String updatedAt;

  SaleItemModel({
    this.id,
    this.saleCode,
    this.productCode,
    this.productName,
    this.unitCode,
    this.unitName,
    this.unitValue,
    this.quantity,
    this.discountValue,
    this.discountPercentage,
    this.finalValue,
    this.totalValue = 0,
    String? code,
    String? createdAt,
    String? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String(),
       code = code ?? Uuid().v4();

  SaleItemModel copyWith({
    int? id,
    String? code,
    String? saleCode,
    String? productCode,
    String? productName,
    String? unitCode,
    String? unitName,
    double? unitValue,
    double? quantity,
    double? discountValue,
    double? discountPercentage,
    double? finalValue,
    double? totalValue,
    String? createdAt,
    String? updatedAt,
  }) {
    return SaleItemModel(
      id: id ?? this.id,
      code: code ?? this.code,
      saleCode: saleCode ?? this.saleCode,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      unitCode: unitCode ?? this.unitCode,
      unitName: unitName ?? this.unitName,
      unitValue: unitValue ?? this.unitValue,
      quantity: quantity ?? this.quantity,
      discountValue: discountValue ?? this.discountValue,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      finalValue: finalValue ?? this.finalValue,
      totalValue: totalValue ?? this.totalValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'saleCode': saleCode,
      'productCode': productCode,
      'productName': productName,
      'unitCode': unitCode,
      'unitName': unitName,
      'unitValue': unitValue,
      'quantity': quantity,
      'discountValue': discountValue,
      'discountPercentage': discountPercentage,
      'finalValue': finalValue,
      'totalValue': totalValue,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory SaleItemModel.fromMap(Map<String, dynamic> map) {
    return SaleItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      saleCode: map['saleCode'] != null ? map['saleCode'] as String : null,
      productCode:
          map['productCode'] != null ? map['productCode'] as String : null,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      unitCode: map['unitCode'] != null ? map['unitCode'] as String : null,
      unitName: map['unitName'] != null ? map['unitName'] as String : null,
      unitValue: map['unitValue'] != null ? map['unitValue'] as double : null,
      quantity: map['quantity'] != null ? map['quantity'] as double : null,
      discountValue:
          map['discountValue'] != null ? map['discountValue'] as double : null,
      discountPercentage:
          map['discountPercentage'] != null
              ? map['discountPercentage'] as double
              : null,
      finalValue:
          map['finalValue'] != null ? map['finalValue'] as double : null,
      totalValue:
          map['totalValue'] != null ? map['totalValue'] as double : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleItemModel.fromJson(String source) =>
      SaleItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SaleItemModel(id: $id, code: $code, saleCode: $saleCode, productCode: $productCode, productName: $productName, unitCode: $unitCode, unitName: $unitName, unitValue: $unitValue, quantity: $quantity, discountValue: $discountValue, discountPercentage: $discountPercentage, finalValue: $finalValue, totalValue: $totalValue, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant SaleItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.saleCode == saleCode &&
        other.productCode == productCode &&
        other.productName == productName &&
        other.unitCode == unitCode &&
        other.unitName == unitName &&
        other.unitValue == unitValue &&
        other.quantity == quantity &&
        other.discountValue == discountValue &&
        other.discountPercentage == discountPercentage &&
        other.finalValue == finalValue &&
        other.totalValue == totalValue &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        saleCode.hashCode ^
        productCode.hashCode ^
        productName.hashCode ^
        unitCode.hashCode ^
        unitName.hashCode ^
        unitValue.hashCode ^
        quantity.hashCode ^
        discountValue.hashCode ^
        discountPercentage.hashCode ^
        finalValue.hashCode ^
        totalValue.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
