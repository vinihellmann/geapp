import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/models/select_object.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';

class CustomerFormProvider extends FormProvider<CustomerModel> {
  CustomerFormProvider() {
    getUFs();
  }

  @override
  String get title => editMode ? "Editar Cliente" : "Novo Cliente";

  @override
  CustomerModel item = CustomerModel();
  final formKey = GlobalKey<FormState>();

  List<SelectObject> ufs = [];
  List<SelectObject> cities = [];

  @override
  Future<void> setEdit(CustomerModel object) async {
    editMode = true;
    item = object.copyWith();
    await getCities(object.addressUF ?? 0);
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
          tableName: "CLIENTES",
          data: item.toMap(),
          whereClause: "code = ?",
          whereArgs: [item.code],
        );

        return result != null;
      }

      final result = await database.insert(
        tableName: "CLIENTES",
        data: item.toMap(),
      );

      return result != null;
    } catch (e) {
      log("CustomerFormProvider::save - $e");
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
        tableName: "CLIENTES",
        whereClause: "code = ?",
        whereArgs: [item.code],
      );

      return result != null;
    } catch (e) {
      log("CustomerFormProvider::delete - $e");
      return null;
    } finally {
      changeIsLoading();
    }
  }

  Future<void> getUFs() async {
    List<SelectObject> items = [];

    final result = await database.query(table: "ESTADOS");
    if (result.isEmpty) return;

    for (var item in result) {
      items.add(SelectObject(
        key: int.parse(item['id'].toString()),
        value: item['sigla'],
      ));
    }

    ufs = items;
    notifyListeners();
  }

  Future<void> getCities(int ufId) async {
    List<SelectObject> items = [];

    final result = await database.query(
      table: "CIDADES",
      where: "estado_id = ?",
      whereArgs: [ufId],
    );

    if (result.isEmpty) return;
    for (var item in result) {
      items.add(SelectObject(
        key: int.parse(item['id_cidade'].toString()),
        value: item['nomeCidade'],
      ));
    }

    cities = items;
    notifyListeners();
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  @override
  void clearData() {
    editMode = false;
    item = CustomerModel();
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
