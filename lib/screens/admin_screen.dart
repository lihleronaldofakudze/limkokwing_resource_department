import 'package:fluent_ui/fluent_ui.dart';
import 'package:limkokwing_resource_department/models/Admin.dart';
import 'package:limkokwing_resource_department/services/admin_db.dart';
import 'package:limkokwing_resource_department/widgets/ok_alert_dialog.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/TableColumn.dart';
import '../widgets/grid_column_widget.dart';
import '../widgets/loading_widget.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Admin>? _admins;
  late AdminDataSource _adminDataSource;
  bool _isLoading = false;
  DataGridController _controller = DataGridController();

  _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    _admins = await getAdminList();
    _adminDataSource = AdminDataSource(_admins!);

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
              'Admin Table',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu'),
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
                  child: Text('Add New Admin',
                      style: TextStyle(fontFamily: 'Ubuntu')),
                  onPressed: _add),
            ),
          ],
        ),
      ),
      content: _isLoading
          ? loadingWidget()
          : Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              child: SfDataGrid(
                  source: _adminDataSource,
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
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text('Add New Administrator'),
              backgroundDismiss: true,
              content: Column(
                children: [
                  TextBox(
                    header: 'Username',
                    placeholder: 'Enter username here',
                    keyboardType: TextInputType.text,
                    controller: _usernameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Password',
                    placeholder: 'Enter password here',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: _passwordController,
                  ),
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
                      Admin admin = new Admin(
                          username: _usernameController.text,
                          password: _passwordController.text);
                      await addAdmin(admin).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Added new admin'));
                        _usernameController.clear();
                        _passwordController.clear();
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
                        _usernameController.clear();
                        _passwordController.clear();
                        _refreshData();
                      });
                    }),
              ],
            ));
  }

  _update() {
    DataGridRow selectedRow = _controller.selectedRow!;
    int id = selectedRow.getCells().first.value;
    final _usernameController = TextEditingController(
        text: selectedRow.getCells().elementAt(1).value.toString());
    final _passwordController = TextEditingController(
        text: selectedRow.getCells().elementAt(2).value.toString());
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text('Add New Administrator'),
              backgroundDismiss: true,
              content: Column(
                children: [
                  TextBox(
                    header: 'Username',
                    placeholder: 'Enter username here',
                    keyboardType: TextInputType.text,
                    controller: _usernameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Password',
                    placeholder: 'Enter password here',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: _passwordController,
                  ),
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
                      Admin admin = new Admin(
                          id: id,
                          username: _usernameController.text,
                          password: _passwordController.text);
                      await updateAdmin(admin).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Added new administrator'));
                        _usernameController.clear();
                        _passwordController.clear();
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
                        _usernameController.clear();
                        _passwordController.clear();
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
                'Delete Administrator',
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
                      await deleteAdmin(id).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Deleted administrator'));
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
    TableColumn(columnName: 'username', text: 'Username'),
    TableColumn(columnName: 'password', text: 'Password'),
  ];
}
