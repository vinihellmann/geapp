import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geapp/app/database/database.dart';
import 'package:geapp/providers/providers.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GEDatabase.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: TColor.background.main,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return Providers(
      child: MaterialApp(
        title: 'GEApp',
        routes: Routes.list,
        themeMode: ThemeMode.dark,
        initialRoute: Routes.login,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
