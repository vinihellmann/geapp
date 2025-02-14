import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/modules/customer/providers/customer_list_provider.dart';
import 'package:provider/provider.dart';

class CustomerProviders {
  static List providers() {
    return [
      ChangeNotifierProvider(create: (context) => CustomerListProvider()),
      ChangeNotifierProvider(create: (context) => CustomerFormProvider()),
    ];
  }
}
