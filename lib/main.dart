import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rideshare/SplashScreens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Map<int, Color> color = {
    50: Color.fromRGBO(7, 45, 61, 0.098),
    100: Color.fromRGBO(7, 74, 100, 0.2),
    200: Color.fromRGBO(12, 74, 100, .3),
    300: Color.fromRGBO(26, 155, 210, 0.4),
    400: Color.fromRGBO(23, 141, 192, 0.498),
    500: Color.fromRGBO(16, 116, 156, 0.6),
    600: Color.fromRGBO(28, 137, 173, 0.694),
    700: Color.fromRGBO(24, 150, 204, 0.8),
    800: Color.fromRGBO(28, 167, 227, 0.898),
    900: Color.fromRGBO(30, 180, 245, 1),
  };
  MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);
  runApp(
    MyApp(
      child: MaterialApp(
        title: 'Carpooling App',
        theme: ThemeData(
          primaryColor: colorCustom,
        ),
        home: const MySplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;
  MyApp({this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}
