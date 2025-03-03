import 'dart:developer';

import 'package:geapp/app/provider/list_provider.dart';
import 'package:geapp/modules/finance/models/finance_model.dart';
import 'package:geapp/modules/finance/repositories/finance_repository.dart';
import 'package:geapp/utils/utils.dart';

class FinanceListProvider extends ListProvider<FinanceModel> {
  FinanceRepository repository;
  FinanceListProvider(this.repository);

  updateDependencies(FinanceRepository repo) {
    repository = repo;
    notifyListeners();
  }

  List<dynamic> whereArgs = [];
  String? whereClause;

  @override
  String orderBy = "dueDate";

  @override
  Future<void> getData() async {
    changeIsLoading();

    try {
      await generateWhere();

      final itemList = <FinanceModel>[];
      final result = await repository.search(
        whereClause,
        whereArgs,
        page,
        limit,
        orderBy,
      );

      for (var item in result.data) {
        final object = FinanceModel.fromMap(item);
        itemList.add(object);
      }

      items = itemList;
      totalItems = result.totalItems;
      totalPages = result.totalPages;

      notifyListeners();
    } catch (e) {
      log("FinanceListProvider::getData - $e");
      Utils.showToast(e.toString(), ToastType.error);
    } finally {
      changeIsLoading();
    }
  }

  Future<void> generateWhere() async {
    List<String> whereList = [];
    whereClause = null;
    whereArgs.clear();

    whereClause = whereList.isNotEmpty ? whereList.join(' AND ') : null;
  }
}
