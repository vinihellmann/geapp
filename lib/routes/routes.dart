import 'package:geapp/app/components/transition.dart';
import 'package:geapp/modules/customer/screens/customer_form_screen.dart';
import 'package:geapp/modules/customer/screens/customer_list_screen.dart';
import 'package:geapp/modules/home/screens/home_screen.dart';
import 'package:geapp/modules/login/screens/login_screen.dart';
import 'package:geapp/modules/product/screens/product_form_screen.dart';
import 'package:geapp/modules/product/screens/product_list_screen.dart';
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
    ],
  );
}
