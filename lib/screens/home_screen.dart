import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:limkokwing_resource_department/widgets/home_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Button(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Logout'),
              ),
            ),
            Text(
              'Limkokwing Resources Administrator Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
                width: 200,
                child: FilledButton(
                    child: Text('Add New Admin'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/admin');
                    }))
          ],
        ),
      ),
      content: Container(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeButton(
                    asset: 'assets/images/login-amico.png',
                    title: 'Stationery',
                    route: '/stationery',
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  HomeButton(
                    asset: 'assets/images/login-amico.png',
                    title: 'Laptop',
                    route: '/laptop',
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeButton(
                    asset: 'assets/images/login-amico.png',
                    title: 'Projectors',
                    route: '/projector',
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  HomeButton(
                    asset: 'assets/images/login-amico.png',
                    title: 'Venues',
                    route: '/venue',
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
