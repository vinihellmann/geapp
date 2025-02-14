import 'dart:developer';

import 'package:geapp/app/provider/provider.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/utils/utils.dart';

class CustomerListProvider extends Provider<CustomerModel> {
  @override
  String tableName = "CLIENTES";

  @override
  String orderBy = "name";

  @override
  Future<void> getData() async {
    changeIsLoading();

    try {
      final itemList = <CustomerModel>[];
      final result = await database.getData(
        tableName: tableName,
        limit: limit,
        page: page,
        orderBy: orderBy,
      );

      for (var item in result.data) {
        final customer = CustomerModel.fromMap(item);
        itemList.add(customer);
      }

      items = itemList;
      totalItems = result.totalItems;
      totalPages = result.totalPages;

      notifyListeners();
    } catch (e) {
      log("CustomerListProvider::getData - $e");
      Utils.showToast(e.toString(), ToastType.error);
    } finally {
      changeIsLoading();
    }
  }
}
