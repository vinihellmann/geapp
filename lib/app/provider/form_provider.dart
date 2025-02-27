import 'dart:async';
import 'package:flutter/material.dart';

abstract class FormProvider<T> with ChangeNotifier {
  @required
  T get item;

  String get title;
  bool isEditing = false;
  bool isLoading = false;
  bool isSaving = false;

  void setCreate();
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

  void changeIsSaving() {
    isSaving = !isSaving;
    notifyListeners();
  }
}
