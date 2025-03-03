import 'dart:convert';

import 'package:uuid/uuid.dart';

class FinanceModel {
  int? id;
  int? type;
  int? status;
  String? code;
  String? saleCode;
  String? customerCode;
  String? customerName;
  String? description;
  double? value;
  String? dueDate;
  String? paymentDate;
  String createdAt;
  String updatedAt;

  FinanceModel({
    String? code,
    String? createdAt,
    String? updatedAt,
    this.id,
    this.type,
    this.status,
    this.saleCode,
    this.customerCode,
    this.customerName,
    this.description,
    this.value,
    this.dueDate,
    this.paymentDate,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String(),
       code = code ?? Uuid().v4();

  FinanceModel copyWith({
    int? id,
    int? type,
    int? status,
    String? code,
    String? saleCode,
    String? customerCode,
    String? customerName,
    String? description,
    double? value,
    String? dueDate,
    String? paymentDate,
    String? createdAt,
    String? updatedAt,
  }) {
    return FinanceModel(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      code: code ?? this.code,
      saleCode: saleCode ?? this.saleCode,
      customerCode: customerCode ?? this.customerCode,
      customerName: customerName ?? this.customerName,
      description: description ?? this.description,
      value: value ?? this.value,
      dueDate: dueDate ?? this.dueDate,
      paymentDate: paymentDate ?? this.paymentDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'status': status,
      'code': code,
      'saleCode': saleCode,
      'customerCode': customerCode,
      'customerName': customerName,
      'description': description,
      'value': value,
      'dueDate': dueDate,
      'paymentDate': paymentDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FinanceModel.fromMap(Map<String, dynamic> map) {
    return FinanceModel(
      id: map['id'] != null ? map['id'] as int : null,
      type: map['type'] != null ? map['type'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      saleCode: map['saleCode'] != null ? map['saleCode'] as String : null,
      customerCode:
          map['customerCode'] != null ? map['customerCode'] as String : null,
      customerName:
          map['customerName'] != null ? map['customerName'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      value: map['value'] != null ? map['value'] as double : null,
      dueDate: map['dueDate'] != null ? map['dueDate'] as String : null,
      paymentDate:
          map['paymentDate'] != null ? map['paymentDate'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinanceModel.fromJson(String source) =>
      FinanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinanceModel(id: $id, type: $type, status: $status, code: $code, saleCode: $saleCode, customerCode: $customerCode, customerName: $customerName, description: $description, value: $value, dueDate: $dueDate, paymentDate: $paymentDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FinanceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.status == status &&
        other.code == code &&
        other.saleCode == saleCode &&
        other.customerCode == customerCode &&
        other.customerName == customerName &&
        other.description == description &&
        other.value == value &&
        other.dueDate == dueDate &&
        other.paymentDate == paymentDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        status.hashCode ^
        code.hashCode ^
        saleCode.hashCode ^
        customerCode.hashCode ^
        customerName.hashCode ^
        description.hashCode ^
        value.hashCode ^
        dueDate.hashCode ^
        paymentDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
