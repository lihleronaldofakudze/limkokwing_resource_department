import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:limkokwing_resource_department/screens/admin_screen.dart';
import 'package:limkokwing_resource_department/screens/laptop_screen.dart';
import 'package:limkokwing_resource_department/screens/projector_screen.dart';
import 'package:limkokwing_resource_department/screens/stationery_screen.dart';
import 'package:limkokwing_resource_department/screens/venue_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Limkokwing University Resource Department',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => AnimatedSplashScreen(
              duration: 700,
              splash:
                  Image.asset('assets/images/Limkokwing_University_Logo.jpg'),
              nextScreen: LoginScreen(),
              centered: true,
            ),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/stationery': (context) => StationeryScreen(),
        '/laptop': (context) => LaptopScreen(),
        '/venue': (context) => VenueScreen(),
        '/projector': (context) => ProjectorScreen(),
        '/admin': (context) => AdminScreen(),
      },
      theme: ThemeData(),
    );
  }
}
