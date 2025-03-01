import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/modules/unit/repositories/unit_repository.dart';
import 'package:provider/provider.dart';

class UnitFormProvider extends FormProvider<UnitModel> {
  UnitRepository repository;
  UnitFormProvider(this.repository);

  updateDependencies(UnitRepository repo) {
    repository = repo;
    notifyListeners();
  }

  @override
  String get title => isEditing ? "Editar Unidade" : "Nova Unidade";

  @override
  UnitModel item = UnitModel();
  final formKey = GlobalKey<FormState>();

  void init(BuildContext context) {
    final code = context.read<UnitListProvider>().product?.code;
    isEditing = false;
    item = UnitModel(productCode: code);
  }

  @override
  Future<void> setCreate() async {
    try {
      isEditing = false;
      item = UnitModel();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> setEdit(UnitModel object) async {
    try {
      isEditing = true;
      item = object.copyWith();
    } catch (e) {
      log(e.toString());
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

  bool validateForm() {
    return formKey.currentState!.validate();
  }
}
