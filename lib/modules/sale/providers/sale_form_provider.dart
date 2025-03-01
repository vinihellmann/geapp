import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/sale/models/sale_item_model.dart';
import 'package:geapp/modules/sale/models/sale_model.dart';
import 'package:geapp/modules/sale/repositories/sale_item_repository.dart';
import 'package:geapp/modules/sale/repositories/sale_repository.dart';

class SaleFormProvider extends FormProvider<SaleModel> {
  SaleRepository repository;
  SaleItemRepository itemRepository;
  SaleFormProvider(this.repository, this.itemRepository);

  updateDependencies(SaleRepository repo, SaleItemRepository itemRepo) {
    repository = repo;
    itemRepository = itemRepo;
    notifyListeners();
  }

  @override
  String get title => isEditing ? "Editar Venda" : "Nova Venda";

  @override
  SaleModel item = SaleModel();
  CustomerModel customer = CustomerModel();
  List<SaleItemModel> items = <SaleItemModel>[];
  final formKey = GlobalKey<FormState>();

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void setCustomer(CustomerModel newCustomer) {
    customer = newCustomer;
    item.customerCode = newCustomer.code;
    item.customerName = newCustomer.name;
    notifyListeners();
  }

  void updateTotalItems() {
    final totalItems = items.fold(0.0, (sum, item) => sum + item.totalValue!);

    item.totalItems = totalItems;
    item.totalValue = totalItems - item.discountValue! + item.additionValue!;
    notifyListeners();
  }

  @override
  Future<void> setCreate() async {
    try {
      isEditing = false;
      item = SaleModel();
      items = <SaleItemModel>[];
      customer = CustomerModel();
    } catch (e) {
      log("SaleFormProvider::setCreate - $e");
    }
  }

  @override
  Future<void> setEdit(SaleModel object) async {
    try {
      isEditing = true;
      items = object.items;
      item = object.copyWith();
      setCustomer(object.customer);
    } catch (e) {
      log("SaleFormProvider::setEdit - $e");
    }
  }

  @override
  Future<bool?> save() async {
    try {
      changeIsSaving();

      final valid = validateForm();
      if (!valid) return null;

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

  void addItem(SaleItemModel saleItem) {
    items.add(saleItem);
    updateTotalItems();
  }

  void updateItem(SaleItemModel saleItem) {
    final index = items.indexWhere((item) {
      return item.code == saleItem.code && item.unitCode == saleItem.unitCode;
    });

    if (index != -1) {
      items[index] = saleItem;
      updateTotalItems();
      return;
    }

    addItem(saleItem);
  }

  void removeItem(SaleItemModel saleItem) {
    items.removeWhere((item) => item.code == saleItem.code);
    updateTotalItems();
  }
}
