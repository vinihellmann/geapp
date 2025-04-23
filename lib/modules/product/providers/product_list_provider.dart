import 'dart:developer';

import 'package:geapp/app/provider/list_provider.dart';
import 'package:geapp/modules/image/models/image_model.dart';
import 'package:geapp/modules/product/models/product_filter_model.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/repositories/product_repository.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/utils/utils.dart';

class ProductListProvider extends ListProvider<ProductModel> {
  ProductRepository repository;
  ProductListProvider(this.repository);

  updateDependencies(ProductRepository repo) {
    repository = repo;
    notifyListeners();
  }

  var filters = ProductFilterModel();
  List<dynamic> whereArgs = [];
  String? whereClause;

  @override
  String orderBy = "name";

  @override
  Future<void> getData() async {
    changeIsLoading();

    try {
      await generateWhere();

      final itemList = <ProductModel>[];
      final result = await repository.search(
        whereClause,
        whereArgs,
        page,
        limit,
        orderBy,
      );

      for (var item in result.data) {
        final object = ProductModel.fromMap(item);
        object.images = await fetchImages(object.code);
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

  Future<void> generateWhere() async {
    List<String> whereList = [];
    whereClause = null;
    whereArgs.clear();

    if (filters.name != null && filters.name != "") {
      whereList.add("name LIKE ?");
      whereArgs.add("%${filters.name}%");
    }

    if (filters.barCode != null && filters.barCode != "") {
      whereList.add("barCode LIKE ?");
      whereArgs.add("%${filters.barCode}%");
    }

    if (filters.brand != null && filters.brand != "") {
      whereList.add("brand LIKE ?");
      whereArgs.add("%${filters.brand}%");
    }

    if (filters.groupName != null && filters.groupName != "") {
      whereList.add("groupName LIKE ?");
      whereArgs.add("%${filters.groupName}%");
    }

    whereClause = whereList.isNotEmpty ? whereList.join(' AND ') : null;
  }

  Future<void> setUnit(ProductModel product, [UnitModel? unit]) async {
    await product.setUnit(unit);
    notifyListeners();
  }

  Future<List<UnitModel>> fetchUnits(String? code) async {
    final result = await repository.fetchUnits(code);
    return result.map((x) => UnitModel.fromMap(x)).toList();
  }

  Future<List<ImageModel>> fetchImages(String? code) async {
    final result = await repository.fetchImages(code);
    return result.map((x) => ImageModel.fromMap(x)).toList();
  }
}
