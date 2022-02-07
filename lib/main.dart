import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
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
        '/home': (context) => HomeScreen()
      },
      theme: ThemeData(),
    );
  }
}