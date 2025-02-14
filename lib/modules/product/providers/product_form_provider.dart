import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';

class ProductFormProvider extends FormProvider<ProductModel> {
  @override
  String get title => editMode ? "Editar Produto" : "Novo Produto";

  @override
  ProductModel item = ProductModel();
  final formKey = GlobalKey<FormState>();

  @override
  Future<void> setEdit(ProductModel object) async {
    editMode = true;
    item = object.copyWith();
    notifyListeners();
  }

  @override
  Future<bool?> save() async {
    try {
      changeIsLoading();

      final valid = validateForm();
      if (!valid) return null;

      if (editMode) {
        final result = await database.update(
          tableName: "PRODUTOS",
          data: item.toMap(),
          whereClause: "code = ?",
          whereArgs: [item.code],
        );

        return result != null;
      }

      final result = await database.insert(
        tableName: "PRODUTOS",
        data: item.toMap(),
      );

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

      var result = await database.delete(
        tableName: "PRODUTOS",
        whereClause: "code = ?",
        whereArgs: [item.code],
      );

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
    editMode = false;
    item = ProductModel();
  }
}
