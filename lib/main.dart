import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geapp/app/database/database.dart';
import 'package:geapp/providers/providers.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = GEDatabase();
  final db = await database.initialize();

  runApp(Providers(database: db, child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: TColor.background.main,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp.router(
      title: 'GEApp',
      themeMode: ThemeMode.dark,
      routerConfig: Routes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
