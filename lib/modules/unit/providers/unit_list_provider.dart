import 'dart:developer';

import 'package:geapp/app/provider/provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/modules/unit/repositories/unit_repository.dart';
import 'package:geapp/utils/utils.dart';

class UnitListProvider extends Provider<UnitModel> {
  UnitRepository repository;
  UnitListProvider(this.repository);

  ProductModel? product;
  UnitModel item = UnitModel();

  void updateRepository(UnitRepository newRepository) {
    repository = newRepository;
    notifyListeners();
  }

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
      final result = await repository.search(
        "productCode = ?",
        [product?.code],
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
}
