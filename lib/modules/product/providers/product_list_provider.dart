import 'dart:developer';

import 'package:geapp/app/provider/provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/repositories/product_repository.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/utils/utils.dart';

class ProductListProvider extends Provider<ProductModel> {
  final ProductRepository repository;
  ProductListProvider(this.repository);

  @override
  String orderBy = "name";

  @override
  Future<void> getData() async {
    changeIsLoading();

    try {
      final itemList = <ProductModel>[];
      final result = await repository.search(null, null, page, limit, orderBy);

      for (var item in result.data) {
        final object = ProductModel.fromMap(item);
        object.units = await fetchUnits(object.code);
        await object.setUnit();
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

  Future<void> setUnit(ProductModel product, [UnitModel? unit]) async {
    await product.setUnit(unit);
    notifyListeners();
  }

  Future<List<UnitModel>> fetchUnits(String? code) async {
    final result = await repository.fetchUnits(code);
    return result.map((x) => UnitModel.fromMap(x)).toList();
  }
}
