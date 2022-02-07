import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:limkokwing_resource_department/models/Projector.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProjectorScreen extends StatefulWidget {
  const ProjectorScreen({Key? key}) : super(key: key);

  @override
  _ProjectorScreenState createState() => _ProjectorScreenState();
}

class _ProjectorScreenState extends State<ProjectorScreen> {
  late List<Projector> _projectors;
  late ProjectorDataSource _projectorDataSource;

  @override
  void initState() {
    _projectors = getProjectorsData();
    _projectorDataSource = ProjectorDataSource(_projectors);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SfDataGrid(
                  columnSizer: ColumnSizer(),
                  source: _projectorDataSource,
                  selectionMode: SelectionMode.single,
                  allowSorting: true,
                  columns: [
                    GridColumn(
                        columnName: 'id',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Id',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'name',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Name',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'serialNumber',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Serial Number',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'status',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Status',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'department',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Department',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'dateTime ',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Date',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ])
            ],
          ),
        ),
      ),
    );
  }

  List<Projector> getProjectorsData() {
    return [
      Projector(
          id: 1,
          name: 'Acer',
          serialNumber: '13579',
          status: 'Available',
          department: 'IT',
          dateTime: DateTime.now()),
      Projector(
          id: 1,
          name: 'HP',
          serialNumber: '13579',
          status: 'In Use',
          department: 'IT',
          dateTime: DateTime.now()),
      Projector(
          id: 1,
          name: 'Acer',
          serialNumber: '13579',
          status: 'Available',
          department: 'IT',
          dateTime: DateTime.now()),
      Projector(
          id: 1,
          name: 'Lenovo',
          serialNumber: '13579',
          status: 'In Use',
          department: 'IT',
          dateTime: DateTime.now()),
      Projector(
          id: 1,
          name: 'Acer',
          serialNumber: '13579',
          status: 'Available',
          department: 'IT',
          dateTime: DateTime.now()),
      Projector(
          id: 1,
          name: 'Samsung',
          serialNumber: '13579',
          status: 'In Use',
          department: 'IT',
          dateTime: DateTime.now()),
      Projector(
          id: 1,
          name: 'Apple',
          serialNumber: '13579',
          status: 'Available',
          department: 'IT',
          dateTime: DateTime.now()),
    ];
  }
}
