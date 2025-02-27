import 'package:geapp/modules/customer/models/customer_model.dart';
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
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: customerList,
        builder: (context, state) => const CustomerListScreen(),
      ),
      GoRoute(
        path: customerForm,
        builder: (context, state) {
          final customer = state.extra as CustomerModel?;
          return CustomerFormScreen(customer: customer);
        },
      ),
      GoRoute(
        path: productList,
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: productForm,
        builder: (context, state) {
          return ProductFormScreen();
        },
      ),
      GoRoute(
        path: unitList,
        builder: (context, state) => const UnitListScreen(),
      ),
      GoRoute(
        path: unitForm,
        builder: (context, state) {
          return UnitFormScreen();
        },
      ),
    ],
  );
}
