import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:provider/provider.dart';

class UnitProviders {
  static List providers() {
    return [
      ChangeNotifierProvider(create: (context) => UnitListProvider()),
      ChangeNotifierProvider(create: (context) => UnitFormProvider()),
    ];
  }
}
