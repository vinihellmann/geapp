import 'dart:convert';

import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/sale/models/sale_item_model.dart';
import 'package:uuid/uuid.dart';

class SaleModel {
  int? id;
  String? code;
  String? customerCode;
  String? customerName;
  int? paymentMethod;
  int? paymentStatus;
  int? paymentCondition;
  double? totalValue;
  double? totalItems;
  double? discountValue;
  double? additionValue;
  double? shippingValue;
  double? discountPercentage;
  double? additionPercentage;
  String? generalNotes;
  String? deliveryDate;
  String createdAt;
  String updatedAt;

  List<SaleItemModel> items = [];
  CustomerModel customer = CustomerModel();

  SaleModel({
    this.id,
    this.customerCode,
    this.customerName,
    this.paymentMethod = 1,
    this.paymentStatus = 1,
    this.paymentCondition = 1,
    this.totalValue = 0,
    this.totalItems = 0,
    this.discountValue = 0,
    this.additionValue = 0,
    this.shippingValue = 0,
    this.discountPercentage = 0,
    this.additionPercentage = 0,
    this.generalNotes,
    this.deliveryDate,
    String? code,
    String? createdAt,
    String? updatedAt,
    List<SaleItemModel>? items,
    CustomerModel? customer,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String(),
       code = code ?? Uuid().v4(),
       customer = customer ?? CustomerModel(),
       items = items ?? [];

  SaleModel copyWith({
    int? id,
    String? code,
    String? customerCode,
    String? customerName,
    int? paymentMethod,
    int? paymentStatus,
    int? paymentCondition,
    double? totalValue,
    double? totalItems,
    double? discountValue,
    double? additionValue,
    double? shippingValue,
    double? discountPercentage,
    double? additionPercentage,
    String? generalNotes,
    String? deliveryDate,
    String? createdAt,
    String? updatedAt,
    List<SaleItemModel>? items,
    CustomerModel? customer,
  }) {
    return SaleModel(
      id: id ?? this.id,
      code: code ?? this.code,
      customerCode: customerCode ?? this.customerCode,
      customerName: customerName ?? this.customerName,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentCondition: paymentCondition ?? this.paymentCondition,
      totalValue: totalValue ?? this.totalValue,
      totalItems: totalItems ?? this.totalItems,
      discountValue: discountValue ?? this.discountValue,
      additionValue: additionValue ?? this.additionValue,
      shippingValue: shippingValue ?? this.shippingValue,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      additionPercentage: additionPercentage ?? this.additionPercentage,
      generalNotes: generalNotes ?? this.generalNotes,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
      customer: customer ?? this.customer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'customerCode': customerCode,
      'customerName': customerName,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentCondition': paymentCondition,
      'totalValue': totalValue,
      'totalItems': totalItems,
      'discountValue': discountValue,
      'additionValue': additionValue,
      'shippingValue': shippingValue,
      'discountPercentage': discountPercentage,
      'additionPercentage': additionPercentage,
      'generalNotes': generalNotes,
      'deliveryDate': deliveryDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      customerCode:
          map['customerCode'] != null ? map['customerCode'] as String : null,
      customerName:
          map['customerName'] != null ? map['customerName'] as String : null,
      paymentMethod:
          map['paymentMethod'] != null ? map['paymentMethod'] as int : null,
      paymentStatus:
          map['paymentStatus'] != null ? map['paymentStatus'] as int : null,
      paymentCondition:
          map['paymentCondition'] != null
              ? map['paymentCondition'] as int
              : null,
      totalValue:
          map['totalValue'] != null ? map['totalValue'] as double : null,
      totalItems:
          map['totalItems'] != null ? map['totalItems'] as double : null,
      discountValue:
          map['discountValue'] != null ? map['discountValue'] as double : null,
      additionValue:
          map['additionValue'] != null ? map['additionValue'] as double : null,
      shippingValue:
          map['shippingValue'] != null ? map['shippingValue'] as double : null,
      discountPercentage:
          map['discountPercentage'] != null
              ? map['discountPercentage'] as double
              : null,
      additionPercentage:
          map['additionPercentage'] != null
              ? map['additionPercentage'] as double
              : null,
      generalNotes:
          map['generalNotes'] != null ? map['generalNotes'] as String : null,
      deliveryDate:
          map['deliveryDate'] != null ? map['deliveryDate'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleModel.fromJson(String source) =>
      SaleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SaleModel(id: $id, code: $code, customerCode: $customerCode, customerName: $customerName, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, paymentCondition: $paymentCondition, totalValue: $totalValue, totalItems: $totalItems, discountValue: $discountValue, additionValue: $additionValue, shippingValue: $shippingValue, discountPercentage: $discountPercentage, additionPercentage: $additionPercentage, generalNotes: $generalNotes, deliveryDate: $deliveryDate, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, customer: $customer)';
  }

  @override
  bool operator ==(covariant SaleModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.customerCode == customerCode &&
        other.customerName == customerName &&
        other.paymentMethod == paymentMethod &&
        other.paymentStatus == paymentStatus &&
        other.paymentCondition == paymentCondition &&
        other.totalValue == totalValue &&
        other.totalItems == totalItems &&
        other.discountValue == discountValue &&
        other.additionValue == additionValue &&
        other.shippingValue == shippingValue &&
        other.discountPercentage == discountPercentage &&
        other.additionPercentage == additionPercentage &&
        other.generalNotes == generalNotes &&
        other.deliveryDate == deliveryDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.items == items &&
        other.customer == customer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        customerCode.hashCode ^
        customerName.hashCode ^
        paymentMethod.hashCode ^
        paymentStatus.hashCode ^
        paymentCondition.hashCode ^
        totalValue.hashCode ^
        totalItems.hashCode ^
        discountValue.hashCode ^
        additionValue.hashCode ^
        shippingValue.hashCode ^
        discountPercentage.hashCode ^
        additionPercentage.hashCode ^
        generalNotes.hashCode ^
        deliveryDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        items.hashCode ^
        customer.hashCode;
  }
}
