import 'package:flutter/material.dart';
import 'package:geapp/modules/customer/screens/customer_form_screen.dart';
import 'package:geapp/modules/customer/screens/customer_list_screen.dart';
import 'package:geapp/modules/home/screens/home_screen.dart';
import 'package:geapp/modules/login/screens/login_screen.dart';
import 'package:geapp/modules/product/screens/product_form_screen.dart';
import 'package:geapp/modules/product/screens/product_list_screen.dart';
import 'package:geapp/modules/unit/screens/unit_form_screen.dart';
import 'package:geapp/modules/unit/screens/unit_list_screen.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';

  static const String customerList = '/customer-list';
  static const String customerForm = '/customer-form';

  static const String productList = '/product-list';
  static const String productForm = '/product-form';

  static const String unitList = '/unit-list';
  static const String unitForm = '/unit-form';

  static Map<String, WidgetBuilder> list = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    customerList: (context) => const CustomerListScreen(),
    customerForm: (context) => const CustomerFormScreen(),
    productList: (context) => const ProductListScreen(),
    productForm: (context) => const ProductFormScreen(),
    unitList: (context) => const UnitListScreen(),
    unitForm: (context) => const UnitFormScreen(),
  };
}
