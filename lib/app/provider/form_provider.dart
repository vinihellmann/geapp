import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geapp/app/services/db_service.dart';

abstract class FormProvider<T> with ChangeNotifier {
  final DBService database = DBService();

  @required
  T get item;

  String get title;
  bool editMode = false;
  bool isLoading = false;

  void clearData();
  void setEdit(T object);

  Future<bool?> save();

  Future<bool?> create() async {
    return null;
  }

  Future<bool?> update() async {
    return null;
  }

  Future<bool?> delete() async {
    return null;
  }

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
