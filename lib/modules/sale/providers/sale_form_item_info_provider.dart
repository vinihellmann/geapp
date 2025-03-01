import 'package:flutter/material.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/sale/models/sale_item_model.dart';
import 'package:geapp/utils/utils.dart';

class SaleFormItemInfoProvider with ChangeNotifier {
  late SaleItemModel item;

  SaleFormItemInfoProvider(ProductModel product, List<SaleItemModel> items) {
    initializeSaleItem(product, items);
  }

  void initializeSaleItem(ProductModel product, List<SaleItemModel> items) {
    item = items.firstWhere(
      (i) =>
          i.productCode == product.code &&
          i.unitCode == product.selectedUnit?.code,
      orElse:
          () => SaleItemModel(
            productCode: product.code,
            productName: product.name,
            unitCode: product.selectedUnit?.code,
            unitName: product.selectedUnit?.unit,
            unitValue: product.selectedUnit?.price ?? 0,
            quantity: 1,
            discountValue: 0,
            discountPercentage: 0,
            finalValue: product.selectedUnit?.price ?? 0,
            totalValue: product.selectedUnit?.price ?? 0,
          ),
    );

    originalValue = item.unitValue!;
    quantityController.text = Utils.formatCurrency(item.quantity);
    finalValueController.text = Utils.formatCurrency(item.unitValue);
    discountPercController.text = Utils.formatCurrency(item.discountPercentage);
    discountValueController.text = Utils.formatCurrency(item.discountValue);

    updateValorTotal();
  }

  double totalValue = 0;
  double originalValue = 0;

  final quantityController = TextEditingController(text: "1");
  final finalValueController = TextEditingController(text: "0");
  final discountPercController = TextEditingController(text: "0");
  final discountValueController = TextEditingController(text: "0");

  get quantity => Utils.parseDouble(quantityController.text);
  get finalValue => Utils.parseDouble(finalValueController.text);
  get discountPercentage => Utils.parseDouble(discountPercController.text);
  get discountValue => Utils.parseDouble(discountValueController.text);
  bool get isValid => quantity > 0 && finalValue > 0 && totalValue > 0;

  addQuantity([double newValue = 1]) {
    double total = quantity + newValue;
    quantityController.text = Utils.formatCurrency(total);

    updateDiscountValue();
    updateDiscountP();
  }

  removeQuantity([double newValue = 1]) {
    double total = quantity - newValue;

    if (quantity >= newValue) {
      quantityController.text = Utils.formatCurrency(total);
    }

    updateDiscountValue();
    updateDiscountP();
  }

  addFinalValue([double newValue = 1]) {
    double total = finalValue + newValue;
    finalValueController.text = Utils.formatCurrency(total);

    updateDiscountValue();
    updateDiscountP();
  }

  removeFinalValue([double newValue = 1]) {
    double total = finalValue - newValue;

    if (finalValue >= newValue) {
      finalValueController.text = Utils.formatCurrency(total);
    }

    updateDiscountValue();
    updateDiscountP();
  }

  addDiscountPerc([double newValue = 1]) {
    double total = discountPercentage + newValue;

    if (total <= 100) {
      discountPercController.text = Utils.formatCurrency(total);
    }

    updateDiscountValue();
  }

  removeDiscountPerc([double newValue = 1]) {
    double total = discountPercentage - newValue;

    if (discountPercentage >= newValue) {
      discountPercController.text = Utils.formatCurrency(total);
    }

    updateDiscountValue();
  }

  addDiscountValue([double newValue = 1]) {
    double total = (discountValue + newValue);

    if (total <= (totalValue + discountValue)) {
      discountValueController.text = Utils.formatCurrency(total);
    }

    updateDiscountP();
  }

  removeDiscountValue([double newValue = 1]) {
    double total = (discountValue - newValue);

    if (discountValue >= newValue) {
      discountValueController.text = Utils.formatCurrency(total);
    }

    updateDiscountP();
  }

  void updateValorTotal() {
    double discountedUnitValue = finalValue - (discountValue / quantity);
    String valueFixed = discountedUnitValue.toStringAsFixed(2);
    double baseTotal = double.parse(valueFixed) * quantity;

    if (baseTotal > 0) {
      totalValue = baseTotal;
    } else {
      totalValue = 0.0;
    }

    notifyListeners();
  }

  void updateDiscountValue() {
    double valorDescontado = finalValue * (discountPercentage / 100);
    String valorDescontadoLimitado = valorDescontado.toStringAsFixed(2);
    double valorDesconto = double.parse(valorDescontadoLimitado) * quantity;

    if (valorDesconto > 0) {
      discountValueController.text = Utils.formatCurrency(valorDesconto);
    }

    updateValorTotal();
  }

  void updateDiscountP() {
    double baseTotal = quantity * finalValue;
    double discountFromValue = (discountValue / baseTotal) * 100;

    if (discountFromValue >= 0) {
      discountPercController.text = Utils.formatCurrency(discountFromValue);
    }

    updateValorTotal();
  }

  SaleItemModel getFilledItem() {
    return SaleItemModel(
      productCode: item.productCode,
      productName: item.productName,
      unitCode: item.unitCode,
      unitName: item.unitName,
      unitValue: finalValue,
      quantity: quantity,
      discountValue: discountValue,
      discountPercentage: discountPercentage,
      finalValue: finalValue,
      totalValue: totalValue,
    );
  }

  void clearFields() {
    quantityController.text = Utils.formatCurrency(1);
    discountPercController.text = Utils.formatCurrency(0);
    discountValueController.text = Utils.formatCurrency(0);
    finalValueController.text = Utils.formatCurrency(originalValue);
    notifyListeners();
  }

  @override
  void dispose() {
    quantityController.dispose();
    finalValueController.dispose();
    discountPercController.dispose();
    discountValueController.dispose();
    super.dispose();
  }
}
