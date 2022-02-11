import 'package:fluent_ui/fluent_ui.dart';
import 'package:limkokwing_resource_department/models/TableColumn.dart';
import 'package:limkokwing_resource_department/services/stationery_db.dart';
import 'package:limkokwing_resource_department/widgets/loading_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/Stationery.dart';
import '../widgets/grid_column_widget.dart';
import '../widgets/ok_alert_dialog.dart';

class StationeryScreen extends StatefulWidget {
  const StationeryScreen({Key? key}) : super(key: key);

  @override
  _StationeryScreenState createState() => _StationeryScreenState();
}

class _StationeryScreenState extends State<StationeryScreen> {
  List<Stationery>? _stationery;
  late StationeryDataSource _stationeryDataSource;
  bool _isLoading = false;
  final DataGridController _controller = DataGridController();

  void _refreshData() async {
    setState(() {
      _isLoading = true;
    });
    _stationery = await getStationeryList();
    _stationeryDataSource = StationeryDataSource(_stationery!);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Row(
          children: [
            Button(
                child: Text('Back'),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                }),
            SizedBox(
              width: 10,
            ),
            Text(
              'Stationery Table',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextButton(
                onPressed: _refreshData,
                child: Text(
                  'Refresh Table',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: FilledButton(
                  child: Text(
                    'Add New Stationery',
                    style: TextStyle(fontFamily: 'Ubuntu'),
                  ),
                  onPressed: _add),
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
                width: 200,
                child: Button(
                    child: Text(
                      'Generate Excel File',
                      style: TextStyle(fontFamily: 'Ubuntu'),
                    ),
                    onPressed: () {}))
          ],
        ),
      ),
      content: _isLoading
          ? loadingWidget()
          : Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              child: SfDataGrid(
                  source: _stationeryDataSource,
                  selectionMode: SelectionMode.single,
                  allowSorting: true,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  controller: _controller,
                  columns: columns
                      .map((column) => gridColumnWidget(
                          columnName: column.columnName, text: column.text))
                      .toList()),
            ),
      bottomBar: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 200,
                child: Button(
                    child: Text(
                      'Update',
                      style:
                          TextStyle(color: Colors.orange, fontFamily: 'Ubuntu'),
                    ),
                    onPressed: _update)),
            Text(
              'SELECT A ROW TO UPDATE OR DELETE',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Ubuntu'),
            ),
            SizedBox(
                width: 200,
                child: Button(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: _delete)),
          ],
        ),
      ),
    );
  }

  _add() {
    final _nameController = TextEditingController();
    final _quantityController = TextEditingController();
    final _employeeController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text('Add New Stationery'),
              backgroundDismiss: true,
              content: Column(
                children: [
                  TextBox(
                    header: 'Stationery Name',
                    placeholder: 'Enter stationery name here',
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Stationery Quantity',
                    placeholder: 'Enter stationery quantity here',
                    keyboardType: TextInputType.number,
                    controller: _quantityController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Employee Name',
                    placeholder: 'Enter employee name here',
                    keyboardType: TextInputType.text,
                    controller: _employeeController,
                  )
                ],
              ),
              actions: [
                Button(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                FilledButton(
                    child: Text('Save'),
                    onPressed: () async {
                      Stationery stationery = new Stationery(
                          name: _nameController.text,
                          quantity: int.parse(_quantityController.text),
                          employee: _employeeController.text,
                          dateTime: DateTime.now().toString());
                      await addStationery(stationery).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Added new stationery'));
                        _nameController.clear();
                        _quantityController.clear();
                        _employeeController.clear();
                        _refreshData();
                      }).catchError((onError) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Failed',
                                message:
                                    'Something went wrong, please try again.'));
                        _nameController.clear();
                        _quantityController.clear();
                        _employeeController.clear();
                        _refreshData();
                      });
                    }),
              ],
            ));
  }

  _update() {
    DataGridRow selectedRow = _controller.selectedRow!;
    int id = selectedRow.getCells().first.value;
    final _nameController = TextEditingController(
        text: selectedRow.getCells().elementAt(1).value.toString());
    final _quantityController = TextEditingController(
        text: selectedRow.getCells().elementAt(2).value.toString());
    final _employeeController = TextEditingController(
        text: selectedRow.getCells().elementAt(3).value.toString());
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text('Update New Stationery'),
              backgroundDismiss: true,
              content: Column(
                children: [
                  TextBox(
                    header: 'Stationery Name',
                    placeholder: 'Enter stationery name here',
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Stationery Quantity',
                    placeholder: 'Enter stationery quantity here',
                    keyboardType: TextInputType.number,
                    controller: _quantityController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Employee Name',
                    placeholder: 'Enter employee name here',
                    keyboardType: TextInputType.text,
                    controller: _employeeController,
                  )
                ],
              ),
              actions: [
                Button(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                FilledButton(
                    child: Text('Update'),
                    onPressed: () async {
                      Stationery stationery = new Stationery(
                          id: id,
                          name: _nameController.text,
                          quantity: int.parse(_quantityController.text),
                          employee: _employeeController.text,
                          dateTime: DateTime.now().toString());
                      await updateStationery(stationery).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Updated stationery'));
                        _nameController.clear();
                        _quantityController.clear();
                        _employeeController.clear();
                        _refreshData();
                      }).catchError((onError) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Failed',
                                message:
                                    'Something went wrong, please try again.'));
                        _nameController.clear();
                        _quantityController.clear();
                        _employeeController.clear();
                        _refreshData();
                      });
                    }),
              ],
            ));
  }

  _delete() {
    DataGridRow selectedRow = _controller.selectedRow!;
    int id = selectedRow.getCells().first.value;
    String name = selectedRow.getCells().elementAt(1).value.toString();
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text(
                'Delete Stationery',
                style: TextStyle(color: Colors.red),
              ),
              content: Text('Are your sure you want to delete ${name}?'),
              actions: [
                Button(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                FilledButton(
                    child: Text('Yes'),
                    onPressed: () async {
                      await deleteStationery(id).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Deleted stationery'));
                        _refreshData();
                      }).catchError((onError) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Failed',
                                message:
                                    'Something went wrong, please try again.'));
                        _refreshData();
                      });
                      ;
                    }),
              ],
            ));
  }

  List<TableColumn> columns = [
    TableColumn(columnName: 'id', text: 'Id'),
    TableColumn(columnName: 'name', text: 'Stationery Name'),
    TableColumn(columnName: 'quantity', text: 'Quantity'),
    TableColumn(columnName: 'employee', text: 'Employee Name'),
    TableColumn(columnName: 'dateTime', text: 'Last Update Date'),
  ];
}
