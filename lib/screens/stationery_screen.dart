import 'package:fluent_ui/fluent_ui.dart';

class StationeryScreen extends StatefulWidget {
  const StationeryScreen({Key? key}) : super(key: key);

  @override
  _StationeryScreenState createState() => _StationeryScreenState();
}

class _StationeryScreenState extends State<StationeryScreen> {
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
