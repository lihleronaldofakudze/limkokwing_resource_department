import 'package:fluent_ui/fluent_ui.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
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
