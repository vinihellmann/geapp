import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geapp/modules/image/models/image_model.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:uuid/uuid.dart';

class ProductModel {
  int? id;
  String? barCode;
  String? code;
  String? name;
  String? brand;
  String? groupName;
  String createdAt;
  String updatedAt;

  String unit = "";
  double stock = 0.0;
  double price = 0.0;
  UnitModel? selectedUnit;
  List<UnitModel> units = [];
  List<ImageModel> images = [];

  ProductModel({
    this.id,
    this.barCode,
    this.code,
    this.name,
    this.brand,
    this.groupName,
    this.selectedUnit,
    List<UnitModel>? units,
    List<ImageModel>? images,
    String? createdAt,
    String? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  ProductModel copyWith({
    int? id,
    String? barCode,
    String? code,
    String? name,
    String? brand,
    String? groupName,
    String? createdAt,
    String? updatedAt,
    List<UnitModel>? units,
    List<ImageModel>? images,
    UnitModel? selectedUnit,
  }) {
    return ProductModel(
      id: id ?? this.id,
      barCode: barCode ?? this.barCode,
      code: code ?? this.code,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      groupName: groupName ?? this.groupName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      units: units ?? this.units,
      images: images ?? this.images,
      selectedUnit: selectedUnit ?? this.selectedUnit,
    );
  }

  Map<String, dynamic> toMap() {
    var uuid = const Uuid();
    String uniqueCode = code ?? uuid.v4();

    return <String, dynamic>{
      'barCode': barCode,
      'code': uniqueCode,
      'name': name,
      'brand': brand,
      'groupName': groupName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as int : null,
      barCode: map['barCode'] != null ? map['barCode'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      groupName: map['groupName'] != null ? map['groupName'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id,barCode: $barCode, code: $code, name: $name, brand: $brand, groupName: $groupName, units: $units, selectedUnit: $selectedUnit, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.barCode == barCode &&
        other.code == code &&
        other.name == name &&
        other.brand == brand &&
        other.groupName == groupName &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.units, units) &&
        listEquals(other.images, images) &&
        other.selectedUnit == selectedUnit;
  }

  @override
  int get hashCode {
    return barCode.hashCode ^
        code.hashCode ^
        name.hashCode ^
        brand.hashCode ^
        groupName.hashCode ^
        units.hashCode ^
        images.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        selectedUnit.hashCode;
  }

  //Inicia o objeto com uma unidade já cadastrada
  //Se já tiver uma unidade inicial, ao ser chamada sem parâmetro, passa a unidade atual para a próxima da lista
  //Atualiza as variáveis de estoque e preço com base na unidade atual
  Future<void> setUnit([UnitModel? unitSet]) async {
    if (units.isEmpty) return;

    if (unitSet != null) {
      selectedUnit = unitSet;
    } else if (selectedUnit == null) {
      selectedUnit = units.first;
    } else {
      int currentIndex = units.indexOf(selectedUnit!);
      int nextIndex = (currentIndex + 1) % units.length;
      selectedUnit = units[nextIndex];
    }

    stock = selectedUnit!.stock ?? 0.0;
    price = selectedUnit!.price ?? 0.0;
    unit = selectedUnit!.unit ?? "";
  }
}
