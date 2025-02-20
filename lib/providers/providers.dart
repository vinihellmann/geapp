import 'package:flutter/material.dart';
import 'package:geapp/modules/customer/providers/customer_providers.dart';
import 'package:geapp/modules/product/providers/product_providers.dart';
import 'package:geapp/modules/unit/providers/unit_providers.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  const Providers({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...CustomerProviders.providers(),
        ...ProductProviders.providers(),
        ...UnitProviders.providers(),
      ],
      child: child,
    );
  }
}
