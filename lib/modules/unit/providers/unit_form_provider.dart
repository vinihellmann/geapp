import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/modules/unit/repositories/unit_repository.dart';
import 'package:provider/provider.dart';

class UnitFormProvider extends FormProvider<UnitModel> {
  final UnitRepository repository;
  final UnitListProvider listProvider;
  UnitFormProvider(this.repository, this.listProvider);

  @override
  String get title => isEditing ? "Editar Unidade" : "Nova Unidade";

  @override
  UnitModel item = UnitModel();
  final formKey = GlobalKey<FormState>();

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void setProductCode(BuildContext context) {
    item.productCode = context.read<UnitListProvider>().product?.code;
  }

  @override
  Future<void> setCreate() async {
    try {
      changeIsLoading();

      isEditing = false;
      item = UnitModel();

      await Future.delayed(Duration(milliseconds: 50));
    } catch (e) {
      log(e.toString());
    } finally {
      changeIsLoading();
    }
  }

  @override
  Future<void> setEdit(UnitModel object) async {
    try {
      changeIsLoading();

      isEditing = true;
      item = object.copyWith();

      await Future.delayed(Duration(milliseconds: 50));
    } catch (e) {
      log(e.toString());
    } finally {
      changeIsLoading();
    }
  }

  @override
  Future<bool?> save() async {
    try {
      changeIsSaving();

      final valid = validateForm();
      if (!valid) return null;

      final result = await repository.upsert(item);
      return result != null;
    } catch (e) {
      log("UnitFormProvider::save - $e");
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
      log("UnitFormProvider::delete - $e");
      return null;
    } finally {
      changeIsLoading();
    }
  }
}
