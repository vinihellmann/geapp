import 'package:flutter/material.dart';

abstract class ListProvider<T> with ChangeNotifier {
  ListProvider() {
    getData();
  }

  String get orderBy;

  get totalItemsShown {
    int previousRecords = (page - 1) * limit;
    return previousRecords + items.length;
  }

  int totalItems = 0;
  int totalPages = 1;
  int limit = 10;
  int page = 1;

  bool isLoading = false;

  List<T> items = <T>[];

  @required
  Future<void> getData();

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
