import 'package:flutter/material.dart';
import 'package:geapp/app/services/db_service.dart';

abstract class Provider<T> with ChangeNotifier {
  Provider() {
    getData();
  }

  final DBService database = DBService();

  String get tableName;
  String get orderBy;

  int totalItems = 0;
  int totalPages = 1;
  int limit = 10;
  int page = 1;

  bool isLoading = false;

  List<T> items = <T>[];

  @required
  void getData();

  void previousPage() {
    if (page > 1) {
      page--;
      getData();
    }
  }

  void nextPage() {
    if (page < totalPages) {
      page++;
      getData();
    }
  }

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
