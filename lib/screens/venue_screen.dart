import 'package:fluent_ui/fluent_ui.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({Key? key}) : super(key: key);

  @override
  _VenueScreenState createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Table(
        defaultColumnWidth: FixedColumnWidth(120.0),
        border: TableBorder.all(
            color: Colors.black, style: BorderStyle.solid, width: 2),
        children: [
          TableRow(children: [
            Column(
                children: [Text('Website', style: TextStyle(fontSize: 20.0))]),
            Column(
                children: [Text('Tutorial', style: TextStyle(fontSize: 20.0))]),
            Column(
                children: [Text('Review', style: TextStyle(fontSize: 20.0))]),
          ]),
        ],
      ),
    );
  }
}
