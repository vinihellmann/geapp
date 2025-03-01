import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/models/select_object.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/customer/repositories/customer_repository.dart';

class CustomerFormProvider extends FormProvider<CustomerModel> {
  CustomerRepository repository;
  CustomerFormProvider(this.repository);

  updateDependencies(CustomerRepository repo) {
    repository = repo;
    notifyListeners();
  }

  @override
  String get title => isEditing ? "Editar Cliente" : "Novo Cliente";

  @override
  CustomerModel item = CustomerModel();
  final formKey = GlobalKey<FormState>();

  List<SelectObject> ufs = [];
  List<SelectObject> cities = [];

  @override
  Future<void> setCreate() async {
    try {
      isEditing = false;
      item = CustomerModel();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> setEdit(CustomerModel object) async {
    try {
      isEditing = true;
      item = object.copyWith();

      await getCities(object.addressUF ?? 0);
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
      log("CustomerFormProvider::save - $e");
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
      log("CustomerFormProvider::delete - $e");
      return null;
    } finally {
      changeIsLoading();
    }
  }

  Future<void> getUFs() async {
    ufs = await repository.getStates();
    notifyListeners();
  }

  Future<void> getCities(int ufId) async {
    cities = await repository.getCities(ufId);
    notifyListeners();
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void changeUF(int value) async {
    item.addressUF = value;
    item.addressCity = null;
    notifyListeners();

    await getCities(value);
  }

  void changeCity(int value) async {
    item.addressCity = value;
    notifyListeners();
  }

  void changeLegal() async {
    item.isLegal = !item.isLegal!;
    notifyListeners();
  }
}
