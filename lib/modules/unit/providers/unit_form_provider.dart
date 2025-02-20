import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:provider/provider.dart';

class UnitFormProvider extends FormProvider<UnitModel> {
  @override
  String get title => editMode ? "Editar Unidade" : "Nova Unidade";

  @override
  UnitModel item = UnitModel();
  final formKey = GlobalKey<FormState>();

  void setProductCode(BuildContext context) {
    item.productCode = context.read<UnitListProvider>().product?.code;
  }

  @override
  Future<void> setEdit(UnitModel object) async {
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
          tableName: "PRODUTOS_UNIDADE",
          data: item.toMap(),
          whereClause: "code = ?",
          whereArgs: [item.code],
        );

        return result != null;
      }

      final result = await database.insert(
        tableName: "PRODUTOS_UNIDADE",
        data: item.toMap(),
      );

      return result != null;
    } catch (e) {
      log("UnitFormProvider::save - $e");
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
        tableName: "PRODUTOS_UNIDADE",
        whereClause: "code = ?",
        whereArgs: [item.code],
      );

      return result != null;
    } catch (e) {
      log("UnitFormProvider::delete - $e");
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
    item = UnitModel();
  }
}
