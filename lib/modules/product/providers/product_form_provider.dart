import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/repositories/product_repository.dart';

class ProductFormProvider extends FormProvider<ProductModel> {
  final ProductRepository repository;
  ProductFormProvider(this.repository);

  @override
  String get title => isEditing ? "Editar Produto" : "Novo Produto";

  @override
  ProductModel item = ProductModel();
  final formKey = GlobalKey<FormState>();

  @override
  Future<void> setEdit(ProductModel object) async {
    isEditing = true;
    item = object.copyWith();
    notifyListeners();
  }

  @override
  Future<bool?> save() async {
    try {
      changeIsLoading();

      final valid = validateForm();
      if (!valid) return null;

      final result = await repository.upsert(item);
      return result != null;
    } catch (e) {
      log("ProductFormProvider::save - $e");
      return null;
    } finally {
      changeIsLoading();
    }
  }

  @override
  Future<bool?> delete() async {
    try {
      changeIsLoading();

      final result = await repository.delete(item);
      return result != null;
    } catch (e) {
      log("ProductFormProvider::delete - $e");
      return null;
    } finally {
      changeIsLoading();
    }
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  @override
  void clearData() {
    isEditing = false;
    item = ProductModel();
  }
}
