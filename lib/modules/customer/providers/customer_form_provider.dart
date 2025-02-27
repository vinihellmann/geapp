import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/models/select_object.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/customer/providers/customer_list_provider.dart';
import 'package:geapp/modules/customer/repositories/customer_repository.dart';

class CustomerFormProvider extends FormProvider<CustomerModel> {
  final CustomerRepository repository;
  final CustomerListProvider listProvider;
  CustomerFormProvider(this.repository, this.listProvider);

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
      changeIsLoading();

      isEditing = false;
      item = CustomerModel();

      await Future.delayed(Duration(milliseconds: 50));
    } catch (e) {
      log(e.toString());
    } finally {
      changeIsLoading();
    }
  }

  @override
  Future<void> setEdit(CustomerModel object) async {
    try {
      changeIsLoading();

      isEditing = true;
      item = object.copyWith();

      await getCities(object.addressUF ?? 0);
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
      listProvider.getData();

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
      listProvider.getData();
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
