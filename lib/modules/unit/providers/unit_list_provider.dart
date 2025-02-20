import 'dart:developer';

import 'package:geapp/app/provider/provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/utils/utils.dart';

class UnitListProvider extends Provider<UnitModel> {
  ProductModel? product;
  UnitModel item = UnitModel();

  @override
  String tableName = "PRODUTOS_UNIDADE";

  @override
  String orderBy = "createdAt";

  Future<void> init(ProductModel model) async {
    product = model;
    await getData();
  }

  @override
  Future<void> getData() async {
    if (product == null) return;

    try {
      changeIsLoading();

      final itemList = <UnitModel>[];
      final result = await database.getData(
        tableName: tableName,
        limit: limit,
        page: page,
        orderBy: orderBy,
        where: "productCode = '${product?.code}'",
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
}
