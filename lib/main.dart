import 'package:flutter/material.dart';
import 'package:routineapp/config/design_system.dart';
import 'package:routineapp/views/auth/register_view.dart';
import 'package:routineapp/views/auth/splash_view.dart';
import 'package:routineapp/views/tasks/tasks_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/auth/login_view.dart';
import 'views/home/home_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', ''), Locale('pt', '')],
      path: 'assets/i18n',
      fallbackLocale: const Locale('en', ''),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user_token');
    if (token != null && token.isNotEmpty) {
      setState(() {
        _initialRoute = '/home'; 
      });
    } else {
      setState(() {
        _initialRoute = '/splash';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoutineApp',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: _initialRoute, 
      routes: {
        '/splash': (context) => const SplashView(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomeView(),
        '/tasks': (context) => const TasksView(),
      },
    );
  }
}