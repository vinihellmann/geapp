import 'dart:developer';

import 'package:geapp/app/provider/list_provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/repositories/product_repository.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/utils/utils.dart';

class ProductListProvider extends ListProvider<ProductModel> {
  ProductRepository repository;
  ProductListProvider(this.repository);

  void updateRepository(ProductRepository newRepository) {
    repository = newRepository;
    notifyListeners();
  }

  @override
  String orderBy = "name";

  @override
  Future<void> getData() async {
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
