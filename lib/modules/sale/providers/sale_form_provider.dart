import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/sale/models/sale_item_model.dart';
import 'package:geapp/modules/sale/models/sale_model.dart';
import 'package:geapp/modules/sale/repositories/sale_item_repository.dart';
import 'package:geapp/modules/sale/repositories/sale_repository.dart';
import 'package:geapp/utils/utils.dart';

class SaleFormProvider extends FormProvider<SaleModel> {
  SaleRepository repository;
  SaleItemRepository itemRepository;
  SaleFormProvider(this.repository, this.itemRepository);

  void updateDependencies(SaleRepository repo, SaleItemRepository itemRepo) {
    repository = repo;
    itemRepository = itemRepo;
    notifyListeners();
  }

  @override
  String get title => isEditing ? "Editar Venda" : "Nova Venda";

  @override
  SaleModel item = SaleModel();
  final formKey = GlobalKey<FormState>();
  CustomerModel customer = CustomerModel();
  List<SaleItemModel> items = <SaleItemModel>[];
  final Map<String, String> validationErrors = {};

  int getItemIndex(SaleItemModel saleItem) {
    return items.indexWhere((item) {
      return item.code == saleItem.code && item.unitCode == saleItem.unitCode;
    });
  }

  @override
  Future<void> setCreate() async {
    isEditing = false;
    item = SaleModel();
    items = <SaleItemModel>[];
    customer = CustomerModel();
  }

  @override
  Future<void> setEdit(SaleModel object) async {
    isEditing = true;
    items = object.items;
    item = object.copyWith();
    setCustomer(object.customer);
  }

  void setCustomer(CustomerModel newCustomer) {
    customer = newCustomer;
    item.customerCode = newCustomer.code;
    item.customerName = newCustomer.name;
    notifyListeners();
  }

  @override
  Future<bool?> save() async {
    try {
      changeIsSaving();

      if (!isValid) {
        showValidationErrors();
        return null;
      }

      final result = await repository.upsert(item);
      await itemRepository.upsertAll(item.code, items);
      return result != null;
    } catch (e) {
      log("SaleFormProvider::save - $e");
      return null;
    } finally {
      changeIsSaving();
    }
  }

  @override
  Future<bool?> delete() async {
    try {
      changeIsLoading();

      final result = await repository.delete(item);
      return result != null;
    } catch (e) {
      log("SaleFormProvider::delete - $e");
      return null;
    } finally {
      changeIsLoading();
    }
  }

  Future<bool> upsertItem(SaleItemModel saleItem) async {
    final canUpsert = await checkUnitStock(saleItem);
    if (!canUpsert) return false;

    final index = getItemIndex(saleItem);

    if (index != -1) {
      items[index] = saleItem;
    } else {
      items.add(saleItem);
    }

    updateTotalItems();
    return true;
  }

  void removeItem(SaleItemModel saleItem) {
    items.removeWhere((item) => item.code == saleItem.code);
    updateTotalItems();
  }

  void updateTotalItems() {
    final totalItems = items.fold(0.0, (sum, item) => sum + item.totalValue!);

    item.totalItems = totalItems;
    item.totalValue = totalItems - item.discountValue! + item.additionValue!;
    notifyListeners();
  }

  Future<bool> checkUnitStock(SaleItemModel saleItem) async {
    try {
      final unitStock = await itemRepository.searchUnitStock(saleItem.unitCode);

      if (saleItem.quantity! > unitStock) {
        Utils.showToast(
          "A quantidade informada é maior que o estoque disponível de ${Utils.formatCurrency(unitStock)} para a unidade ${saleItem.unitName?.toUpperCase()}",
          ToastType.error,
        );
        return false;
      }

      return true;
    } catch (e) {
      log("SaleFormProvider::checkUnitStock - $e");
      return false;
    }
  }

  void showValidationErrors() {
    if (validationErrors.isNotEmpty) {
      String errorMessages = validationErrors.values.join("\n");
      Utils.showToast(errorMessages, ToastType.error);
    }
  }

  bool get isValid {
    validationErrors.clear();

    if (customer.code == null) {
      validationErrors["customer"] = "Selecione um cliente para a venda.";
    }

    if (items.isEmpty) {
      validationErrors["items"] = "Adicione pelo menos um item à venda.";
    }

    if (item.paymentStatus == null) {
      validationErrors["paymentStatus"] = "Selecione o status do pagamento.";
    }

    if (item.paymentMethod == null) {
      validationErrors["paymentMethod"] = "Escolha uma forma de pagamento.";
    }

    if (item.paymentCondition == null) {
      validationErrors["paymentCondition"] = "Defina a condição de pagamento.";
    }

    if (item.deliveryDate == null) {
      validationErrors["deliveryDate"] = "Informe a data de entrega.";
    }

    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      validationErrors["form"] =
          "Preencha corretamente os campos obrigatórios.";
    }

    return validationErrors.isEmpty;
  }
}
