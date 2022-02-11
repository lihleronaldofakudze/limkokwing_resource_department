import 'package:fluent_ui/fluent_ui.dart';
import 'package:limkokwing_resource_department/models/Projector.dart';
import 'package:limkokwing_resource_department/services/laptop_db.dart';
import 'package:limkokwing_resource_department/widgets/ok_alert_dialog.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/TableColumn.dart';
import '../services/projector_db.dart';
import '../widgets/grid_column_widget.dart';
import '../widgets/loading_widget.dart';

class ProjectorScreen extends StatefulWidget {
  const ProjectorScreen({Key? key}) : super(key: key);

  @override
  _ProjectorScreenState createState() => _ProjectorScreenState();
}

class _ProjectorScreenState extends State<ProjectorScreen> {
  List<Projector>? _projectors;
  late ProjectorDataSource _projectorDataSource;
  bool _isLoading = false;
  DataGridController _controller = DataGridController();

  _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    _projectors = await getProjectorList();
    _projectorDataSource = ProjectorDataSource(_projectors!);

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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
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
              'Projector Table',
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
                    'Add New Projector',
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
                  source: _projectorDataSource,
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
              'SELECT TO UPDATE OR DELETE',
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
                      style: TextStyle(color: Colors.red, fontFamily: 'Ubuntu'),
                    ),
                    onPressed: _delete)),
          ],
        ),
      ),
    );
  }

  _add() {
    final _laptopNameController = TextEditingController();
    final _serialNumberController = TextEditingController();
    final _statusController = TextEditingController();
    final _departmentController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text('Add New Projector'),
              backgroundDismiss: true,
              content: Column(
                children: [
                  TextBox(
                    header: 'Projector Name',
                    placeholder: 'Enter projector name here',
                    keyboardType: TextInputType.text,
                    controller: _laptopNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Serial Number',
                    placeholder: 'Enter serial number here',
                    keyboardType: TextInputType.number,
                    controller: _serialNumberController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Department',
                    placeholder: 'Enter department here',
                    keyboardType: TextInputType.text,
                    controller: _departmentController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Status',
                    placeholder: 'Enter status here',
                    keyboardType: TextInputType.text,
                    controller: _statusController,
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
                      Projector projector = new Projector(
                          name: _laptopNameController.text,
                          serialNumber: _serialNumberController.text,
                          status: _statusController.text,
                          department: _departmentController.text,
                          dateTime: DateTime.now().toString());
                      await addProjector(projector).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Added new projector'));
                        _laptopNameController.clear();
                        _serialNumberController.clear();
                        _statusController.clear();
                        _departmentController.clear();
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
                        _laptopNameController.clear();
                        _serialNumberController.clear();
                        _statusController.clear();
                        _departmentController.clear();
                        _refreshData();
                      });
                    }),
              ],
            ));
  }

  _update() {
    DataGridRow selectedRow = _controller.selectedRow!;
    int id = selectedRow.getCells().first.value;
    final _projectorNameController = TextEditingController(
        text: selectedRow.getCells().elementAt(1).value.toString());
    final _serialNumberController = TextEditingController(
        text: selectedRow.getCells().elementAt(2).value.toString());
    final _statusController = TextEditingController(
        text: selectedRow.getCells().elementAt(3).value.toString());
    final _departmentController = TextEditingController(
        text: selectedRow.getCells().elementAt(4).value.toString());
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text('Add New Projector'),
              backgroundDismiss: true,
              content: Column(
                children: [
                  TextBox(
                    header: 'Projector Name',
                    placeholder: 'Enter projector name here',
                    keyboardType: TextInputType.text,
                    controller: _projectorNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Serial Number',
                    placeholder: 'Enter serial number here',
                    keyboardType: TextInputType.number,
                    controller: _serialNumberController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Department',
                    placeholder: 'Enter department here',
                    keyboardType: TextInputType.text,
                    controller: _departmentController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Status',
                    placeholder: 'Enter status here',
                    keyboardType: TextInputType.text,
                    controller: _statusController,
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
                      Projector projector = new Projector(
                          id: id,
                          name: _projectorNameController.text,
                          serialNumber: _serialNumberController.text,
                          status: _statusController.text,
                          department: _departmentController.text,
                          dateTime: DateTime.now().toString());
                      await updateProjector(projector).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Added new projector'));
                        _projectorNameController.clear();
                        _serialNumberController.clear();
                        _statusController.clear();
                        _departmentController.clear();
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
                        _projectorNameController.clear();
                        _serialNumberController.clear();
                        _statusController.clear();
                        _departmentController.clear();
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
                'Delete Projector',
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
                      await deleteLaptop(id).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Deleted projector'));
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

  final List<TableColumn> columns = [
    TableColumn(columnName: 'id', text: 'Id'),
    TableColumn(columnName: 'name', text: 'Name'),
    TableColumn(columnName: 'serialNumber', text: 'Serial Number'),
    TableColumn(columnName: 'status', text: 'Status'),
    TableColumn(columnName: 'department', text: 'Department'),
    TableColumn(columnName: 'dateTime', text: 'Last Updated Date'),
  ];
}
