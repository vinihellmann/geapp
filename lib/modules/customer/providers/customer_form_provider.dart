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
    isEditing = false;
    item = CustomerModel();
  }

  @override
  Future<void> setEdit(CustomerModel object) async {
    try {
      isEditing = true;
      item = object.copyWith();

      await getCities(object.addressUF!);
    } catch (e) {
      log("CustomerFormProvider::setEdit - $e");
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
    try {
      ufs = await repository.getStates();
      notifyListeners();
    } catch (e) {
      log("CustomerFormProvider::getUFs - $e");
    }
  }

  Future<void> getCities(String state) async {
    try {
      cities = await repository.getCities(state);
      notifyListeners();
    } catch (e) {
      log("CustomerFormProvider::getCities - $e");
    }
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void changeUF(String value) async {
    item.addressUF = value;
    item.addressCity = null;
    notifyListeners();

    await getCities(value);
  }

  void changeCity(String value) async {
    item.addressCity = value;
    notifyListeners();
  }

  void changeLegal() async {
    item.isLegal = !item.isLegal!;
    notifyListeners();
  }
}
