import 'dart:convert';

class UnitModel {
  String? productCode;
  String? unit;
  double? stock;
  double? price;
  String createdAt;
  String updatedAt;

  UnitModel({
    this.productCode,
    this.unit,
    this.stock,
    this.price,
    String? createdAt,
    String? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  UnitModel copyWith({
    String? productCode,
    String? unit,
    double? stock,
    double? price,
    String? createdAt,
    String? updatedAt,
  }) {
    return UnitModel(
      productCode: productCode ?? this.productCode,
      unit: unit ?? this.unit,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
    return 'UnitModel(productCode: $productCode, unit: $unit, stock: $stock, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UnitModel other) {
    if (identical(this, other)) return true;

    return other.productCode == productCode &&
        other.unit == unit &&
        other.stock == stock &&
        other.price == price &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return productCode.hashCode ^
        unit.hashCode ^
        stock.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
