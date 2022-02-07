import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:limkokwing_resource_department/models/Projector.dart';
import 'package:limkokwing_resource_department/services/projector_db.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProjectorScreen extends StatefulWidget {
  const ProjectorScreen({Key? key}) : super(key: key);

  @override
  _ProjectorScreenState createState() => _ProjectorScreenState();
}

class _ProjectorScreenState extends State<ProjectorScreen> {
  List<Projector>? _projectors;
  late ProjectorDataSource _projectorDataSource;
  bool _loading = false;

  _refreshData() async {
    setState(() {
      _loading = true;
    });

    _projectors = await getProjectorList();
    _projectorDataSource = ProjectorDataSource(_projectors!);
    setState(() {
      _loading = false;
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
      content: _loading
          ? Center(
              child: ProgressBar(),
            )
          : Container(
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
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        allowPullToRefresh: true,
                        columns: [
                          GridColumn(
                              columnWidthMode: ColumnWidthMode.fill,
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
                              columnWidthMode: ColumnWidthMode.fill,
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
                              columnWidthMode: ColumnWidthMode.fill,
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
                              columnWidthMode: ColumnWidthMode.fill,
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
                              columnWidthMode: ColumnWidthMode.fill,
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
                              columnWidthMode: ColumnWidthMode.fill,
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
}
