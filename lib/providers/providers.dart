import 'package:flutter/material.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/customer/providers/customer_providers.dart';
import 'package:geapp/modules/finance/providers/finance_providers.dart';
import 'package:geapp/modules/image/providers/image_providers.dart';
import 'package:geapp/modules/product/providers/product_providers.dart';
import 'package:geapp/modules/sale/providers/sale_providers.dart';
import 'package:geapp/modules/unit/providers/unit_providers.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Providers extends StatelessWidget {
  const Providers({super.key, required this.child, required this.database});

  final Widget child;
  final Database database;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DBService>(create: (context) => DBService(database)),
        ...FinanceProviders.all(),
        ...CustomerProviders.all(),
        ...ProductProviders.all(),
        ...UnitProviders.all(),
        ...ImageProviders.all(),
        ...SaleProviders.all(),
      ],
      child: child,
    );
  }
}
