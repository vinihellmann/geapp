import 'dart:developer';

import 'package:geapp/app/provider/list_provider.dart';
import 'package:geapp/modules/sale/models/sale_model.dart';
import 'package:geapp/modules/sale/repositories/sale_item_repository.dart';
import 'package:geapp/modules/sale/repositories/sale_repository.dart';
import 'package:geapp/utils/utils.dart';

class SaleListProvider extends ListProvider<SaleModel> {
  SaleRepository repository;
  SaleItemRepository itemRepository;
  SaleListProvider(this.repository, this.itemRepository);

  List<dynamic> whereArgs = [];
  String? whereClause;

  updateDependencies(SaleRepository repo, SaleItemRepository itemRepo) {
    repository = repo;
    itemRepository = itemRepo;
    notifyListeners();
  }

  @override
  String orderBy = "id";

  @override
  Future<void> getData() async {
    changeIsLoading();

    try {
      await generateWhere();

      final itemList = <SaleModel>[];
      final teste = await itemRepository.search(
        null,
        null,
        page,
        99999,
        orderBy,
      );
      log(teste.toString());

      final result = await repository.search(
        whereClause,
        whereArgs,
        page,
        limit,
        orderBy,
      );

      for (var item in result.data) {
        final object = SaleModel.fromMap(item);
        object.items = await itemRepository.searchBySale(object.code);
        itemList.add(object);
      }

      items = itemList;
      totalItems = result.totalItems;
      totalPages = result.totalPages;

      notifyListeners();
    } catch (e) {
      log("SaleListProvider::getData - $e");
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

  Future<int?> delete(SaleModel item) async {
    try {
      final result = await repository.delete(item);
      getData();
      return result;
    } catch (e) {
      log("SaleListProvider::delete - $e");
      return null;
    }
  }
}
