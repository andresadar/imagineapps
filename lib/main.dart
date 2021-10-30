import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:imagine_apps/ui/screens/home/controller/bottom_nav_controller.dart.dart';
import 'package:imagine_apps/ui/screens/home/controller/controller.dart';
import 'package:imagine_apps/ui/screens/home/home_page.dart';
import 'package:imagine_apps/ui/screens/new_publication/controller/controller.dart';
import 'package:imagine_apps/ui/screens/new_publication/new_publication_page.dart';
import 'package:imagine_apps/ui/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostController(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Imagine Apps',
        theme: MyTheme.themeLight,
        initialRoute: '/home',
        routes: {
          '/home': (_) => const HomePage(),
          '/post': (_) => const NewPublicationPage(),
        },
      ),
    );
  }
}
