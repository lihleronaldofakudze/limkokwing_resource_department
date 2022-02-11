import 'package:fluent_ui/fluent_ui.dart';
import 'package:limkokwing_resource_department/models/TableColumn.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/Venue.dart';
import '../services/venue_db.dart';
import '../widgets/grid_column_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/ok_alert_dialog.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({Key? key}) : super(key: key);

  @override
  _VenueScreenState createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  List<Venue>? _venues;
  late VenueDataSource _venueDataSource;
  bool _isLoading = false;
  final DataGridController _controller = DataGridController();

  _refreshData() async {
    setState(() {
      _isLoading = true;
    });
    _venues = await getVenueList();
    _venueDataSource = VenueDataSource(_venues!);
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
              'Venue Table',
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
                    'Add New Venue',
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
                  source: _venueDataSource,
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
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: _update)),
            Text(
              'SELECT TO UPDATE OR DELETE',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
    final _bookedByController = TextEditingController();
    final _nameOfEventController = TextEditingController();
    final _statusController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text('Add New Venue'),
              backgroundDismiss: true,
              content: Column(
                children: [
                  TextBox(
                    header: 'Venue Name',
                    placeholder: 'Enter venue name here',
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Booked By',
                    placeholder: 'Enter employee name here',
                    keyboardType: TextInputType.number,
                    controller: _bookedByController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Name Of Event',
                    placeholder: 'Enter name of event here',
                    keyboardType: TextInputType.text,
                    controller: _nameOfEventController,
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
                      Venue venue = new Venue(
                          name: _nameController.text,
                          bookedBy: _bookedByController.text,
                          nameOfEvent: _nameOfEventController.text,
                          status: _statusController.text,
                          dateTime: DateTime.now().toString());
                      await addVenue(venue).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Added new venue'));
                        _nameController.clear();
                        _bookedByController.clear();
                        _nameOfEventController.clear();
                        _statusController.clear();
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
                        _bookedByController.clear();
                        _nameOfEventController.clear();
                        _statusController.clear();
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
    final _bookedByController = TextEditingController(
        text: selectedRow.getCells().elementAt(2).value.toString());
    final _nameOfEventController = TextEditingController(
        text: selectedRow.getCells().elementAt(3).value.toString());
    final _statusController = TextEditingController(
        text: selectedRow.getCells().elementAt(4).value.toString());
    showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text('Update Venue'),
              backgroundDismiss: true,
              content: Column(
                children: [
                  TextBox(
                    header: 'Venue Name',
                    placeholder: 'Enter venue name here',
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Booked By',
                    placeholder: 'Enter employee name here',
                    keyboardType: TextInputType.number,
                    controller: _bookedByController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextBox(
                    header: 'Name Of Event',
                    placeholder: 'Enter name of event here',
                    keyboardType: TextInputType.text,
                    controller: _nameOfEventController,
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
                    child: Text('Update'),
                    onPressed: () async {
                      Venue venue = new Venue(
                          id: id,
                          name: _nameController.text,
                          bookedBy: _bookedByController.text,
                          nameOfEvent: _nameOfEventController.text,
                          status: _statusController.text,
                          dateTime: DateTime.now().toString());
                      await updateVenue(venue).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message:
                                    'Updated venue ${_nameController.text}'));
                        _nameController.clear();
                        _bookedByController.clear();
                        _nameOfEventController.clear();
                        _statusController.clear();
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
                        _bookedByController.clear();
                        _nameOfEventController.clear();
                        _statusController.clear();
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
                'Delete Venue',
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
                      await deleteVenue(id).then((value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => okAlertDialog(
                                context: context,
                                title: 'Successfully',
                                message: 'Deleted venue'));
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
    TableColumn(columnName: 'name', text: 'Venue Name'),
    TableColumn(columnName: 'bookedBy', text: 'Booked By'),
    TableColumn(columnName: 'nameOfEvent', text: 'Name of Event'),
    TableColumn(columnName: 'status', text: 'Status'),
    TableColumn(columnName: 'dateTime', text: 'Date'),
  ];
}
