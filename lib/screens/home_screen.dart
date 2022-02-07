import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limkokwing_resource_department/screens/admin_screen.dart';
import 'package:limkokwing_resource_department/screens/laptop_screen.dart';
import 'package:limkokwing_resource_department/screens/projector_screen.dart';
import 'package:limkokwing_resource_department/screens/stationery_screen.dart';
import 'package:limkokwing_resource_department/screens/venue_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: _currentIndex,
        onChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        header: Padding(
          padding: EdgeInsets.all(10),
          child: IconButton(
              icon: Icon(FluentIcons.collapse_menu), onPressed: () {}),
        ),
        size: NavigationPaneSize(openWidth: 200),
        items: [
          PaneItem(
              icon: Icon(FluentIcons.book_answers), title: Text('Stationery')),
          PaneItem(icon: Icon(FluentIcons.home_verify), title: Text('Venue')),
          PaneItem(
              icon: Icon(FluentIcons.security_camera),
              title: Text('Projectors')),
          PaneItem(
              icon: Icon(FluentIcons.laptop_selected), title: Text('Laptops')),
        ],
        footerItems: [
          PaneItem(icon: Icon(FluentIcons.admin), title: Text('Admin Settings'))
        ],
        displayMode: PaneDisplayMode.open,
      ),
      appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Dashboard',
              style: GoogleFonts.ubuntu(color: Colors.black),
            ),
          )),
      content: NavigationBody(
        index: _currentIndex,
        children: [
          StationeryScreen(),
          VenueScreen(),
          ProjectorScreen(),
          LaptopScreen(),
          AdminScreen()
        ],
      ),
    );
  }
}
