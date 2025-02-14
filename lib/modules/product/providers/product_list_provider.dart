import 'dart:developer';

import 'package:geapp/app/provider/provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/utils/utils.dart';

class ProductListProvider extends Provider<ProductModel> {
  @override
  String tableName = "PRODUTOS";

  @override
  String orderBy = "name";

  @override
  Future<void> getData() async {
    changeIsLoading();

    try {
      final itemList = <ProductModel>[];
      final result = await database.getData(
        tableName: tableName,
        limit: limit,
        page: page,
        orderBy: orderBy,
      );

      for (var item in result.data) {
        final object = ProductModel.fromMap(item);
        await object.init();
        itemList.add(object);
      }

      items = itemList;
      totalItems = result.totalItems;
      totalPages = result.totalPages;

      notifyListeners();
    } catch (e) {
      log("ProductListProvider::getData - $e");
      Utils.showToast(e.toString(), ToastType.error);
    } finally {
      changeIsLoading();
    }
  }
}
