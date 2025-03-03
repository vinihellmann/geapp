import 'package:geapp/app/components/transition.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/customer/screens/customer_form_screen.dart';
import 'package:geapp/modules/customer/screens/customer_list_screen.dart';
import 'package:geapp/modules/finance/screens/finance_list_screen.dart';
import 'package:geapp/modules/home/screens/home_screen.dart';
import 'package:geapp/modules/login/screens/login_screen.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/screens/product_form_screen.dart';
import 'package:geapp/modules/product/screens/product_list_screen.dart';
import 'package:geapp/modules/sale/screens/sale_form_item_info.dart';
import 'package:geapp/modules/sale/screens/sale_form_screen.dart';
import 'package:geapp/modules/sale/screens/sale_list_screen.dart';
import 'package:geapp/modules/unit/screens/unit_form_screen.dart';
import 'package:geapp/modules/unit/screens/unit_list_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';

  static const String customerList = '/customer-list';
  static const String customerForm = '/customer-form';

  static const String productList = '/product-list';
  static const String productForm = '/product-form';

  static const String unitList = '/unit-list';
  static const String unitForm = '/unit-form';

  static const String saleList = '/sale-list';
  static const String saleForm = '/sale-form';
  static const String saleFormItemInfo = '/sale-form/item-info';
  static const String saleFormSelectCustomer = '/sale-form/select-customer';
  static const String saleFormSelectProduct = '/sale-form/select-product';

  static const String financeList = '/finance-list';
  static const String financeForm = '/finance-list';

  static final GoRouter router = GoRouter(
    initialLocation: Routes.login,
    routes: [
      GoRoute(
        path: login,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, LoginScreen());
        },
      ),
      GoRoute(
        path: home,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, HomeScreen());
        },
      ),
      GoRoute(
        path: customerList,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, CustomerListScreen());
        },
      ),
      GoRoute(
        path: customerForm,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, CustomerFormScreen());
        },
      ),
      GoRoute(
        path: productList,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, ProductListScreen());
        },
      ),
      GoRoute(
        path: productForm,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, ProductFormScreen());
        },
      ),
      GoRoute(
        path: unitList,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, UnitListScreen());
        },
      ),
      GoRoute(
        path: unitForm,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, UnitFormScreen());
        },
      ),
      GoRoute(
        path: saleList,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, SaleListScreen());
        },
      ),
      GoRoute(
        path: saleForm,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, SaleFormScreen());
        },
      ),
      GoRoute(
        path: saleFormItemInfo,
        pageBuilder: (context, state) {
          final item = state.extra as Object;
          return Transition.pageTransition(state, SaleFormItemInfo(item: item));
        },
      ),
      GoRoute(
        path: saleFormSelectCustomer,
        pageBuilder: (context, state) {
          final onClick = state.extra as void Function(CustomerModel)?;
          return Transition.pageTransition(
            state,
            CustomerListScreen(onClick: onClick),
          );
        },
      ),
      GoRoute(
        path: saleFormSelectProduct,
        pageBuilder: (context, state) {
          final onClick = state.extra as void Function(ProductModel)?;
          return Transition.pageTransition(
            state,
            ProductListScreen(onClick: onClick),
          );
        },
      ),
      GoRoute(
        path: financeList,
        pageBuilder: (context, state) {
          return Transition.pageTransition(state, FinanceListScreen());
        },
      ),
    ],
  );
}
