import 'dart:developer';

import 'package:geapp/app/provider/list_provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/unit/models/unit_filter_model.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/modules/unit/repositories/unit_repository.dart';
import 'package:geapp/utils/utils.dart';

class UnitListProvider extends ListProvider<UnitModel> {
  final UnitRepository repository;
  UnitListProvider(this.repository);

  ProductModel? product;
  UnitModel item = UnitModel();

  var filters = UnitFilterModel();
  List<dynamic> whereArgs = [];
  String? whereClause;

  @override
  String orderBy = "createdAt";

  Future<void> init(ProductModel model) async {
    product = model;
    await getData();
  }

  @override
  Future<void> getData() async {
    if (product == null) return;
    changeIsLoading();

    try {
      await generateWhere();

      final itemList = <UnitModel>[];
      final result = await repository.search(
        whereClause,
        whereArgs,
        page,
        limit,
        orderBy,
      );

      for (var item in result.data) {
        final object = UnitModel.fromMap(item);
        itemList.add(object);
      }

      items = itemList;
      totalItems = result.totalItems;
      totalPages = result.totalPages;

      notifyListeners();
    } catch (e) {
      log("UnitListProvider::getData - $e");
      Utils.showToast(e.toString(), ToastType.error);
    } finally {
      changeIsLoading();
    }
  }

  Future<void> generateWhere() async {
    List<String> whereList = [];
    whereClause = null;
    whereArgs.clear();

    whereList.add("productCode = ?");
    whereArgs.add(product?.code);

    if (filters.unit != null && filters.unit != "") {
      whereList.add("unit LIKE ?");
      whereArgs.add("%${filters.unit}%");
    }

    whereClause = whereList.isNotEmpty ? whereList.join(' AND ') : null;
  }
}
