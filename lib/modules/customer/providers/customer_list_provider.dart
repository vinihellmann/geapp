import 'dart:developer';

import 'package:geapp/app/provider/provider.dart';
import 'package:geapp/modules/customer/models/customer_filter_model.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/customer/repositories/customer_repository.dart';
import 'package:geapp/utils/utils.dart';

class CustomerListProvider extends Provider<CustomerModel> {
  final CustomerRepository repository;
  CustomerListProvider(this.repository);

  var filters = CustomerFilterModel();
  List<dynamic> whereArgs = [];
  String? whereClause;

  @override
  String orderBy = "name";

  @override
  Future<void> getData() async {
    changeIsLoading();

    try {
      await generateWhere();

      final itemList = <CustomerModel>[];
      final result = await repository.search(
        whereClause,
        whereArgs,
        page,
        limit,
        orderBy,
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

  Future<void> generateWhere() async {
    List<String> whereList = [];
    whereClause = null;
    whereArgs.clear();

    if (filters.name != null && filters.name != "") {
      whereList.add("name LIKE ?");
      whereArgs.add("%${filters.name}%");
    }

    if (filters.fantasy != null && filters.fantasy != "") {
      whereList.add("fantasy LIKE ?");
      whereArgs.add("%${filters.fantasy}%");
    }

    if (filters.cpf != null && filters.cpf != "") {
      whereList.add("cpf LIKE ?");
      whereArgs.add("%${filters.cpf}%");
    }

    if (filters.cnpj != null && filters.cnpj != "") {
      whereList.add("cnpj LIKE ?");
      whereArgs.add("%${filters.cnpj}%");
    }

    if (filters.inscription != null && filters.inscription != "") {
      whereList.add("inscription LIKE ?");
      whereArgs.add("%${filters.inscription}%");
    }

    if (filters.email != null && filters.email != "") {
      whereList.add("email LIKE ?");
      whereArgs.add("%${filters.email}%");
    }

    whereClause = whereList.isNotEmpty ? whereList.join(' AND ') : null;
  }
}
