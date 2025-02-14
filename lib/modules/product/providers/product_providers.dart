import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:provider/provider.dart';

class ProductProviders {
  static List providers() {
    return [
      ChangeNotifierProvider(create: (context) => ProductListProvider()),
      ChangeNotifierProvider(create: (context) => ProductFormProvider()),
    ];
  }
}
