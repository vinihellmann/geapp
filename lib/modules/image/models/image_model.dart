// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class ImageModel {
  int? id;
  String? code;
  String? productCode;
  String? image;
  String createdAt;

  ImageModel({
    this.id,
    this.code,
    this.productCode,
    this.image,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    var uuid = const Uuid();
    String uniqueCode = code ?? uuid.v4();

    return {
      'code': uniqueCode,
      'image': image,
      'productCode': productCode,
      'createdAt': createdAt,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      productCode: map['productCode'] != null ? map['productCode'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['createdAt'] as String,
    );
  }

  ImageModel copyWith({
    int? id,
    String? code,
    String? productCode,
    String? image,
    String? createdAt,
  }) {
    return ImageModel(
      id: id ?? this.id,
      code: code ?? this.code,
      productCode: productCode ?? this.productCode,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'ImageModel(id: $id, code: $code, productCode: $productCode, image: $image, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ImageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.code == code &&
      other.productCode == productCode &&
      other.image == image &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      code.hashCode ^
      productCode.hashCode ^
      image.hashCode ^
      createdAt.hashCode;
  }
}
