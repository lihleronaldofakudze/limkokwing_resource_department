import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Projector {
  final int id;
  final String name;
  final String serialNumber;
  final String status;
  final String department;
  final DateTime dateTime;

  Projector(
      {required this.id,
      required this.name,
      required this.serialNumber,
      required this.status,
      required this.department,
      required this.dateTime});
}

class ProjectorDataSource extends DataGridSource {
  ProjectorDataSource(List<Projector> projectors) {
    dataGridRows = projectors
        .map((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'serialNumber', value: dataGridRow.serialNumber),
              DataGridCell<String>(
                  columnName: 'status', value: dataGridRow.status),
              DataGridCell<String>(
                  columnName: 'department', value: dataGridRow.department),
              DataGridCell<DateTime>(
                  columnName: 'dateTime', value: dataGridRow.dateTime),
            ]))
        .toList();
  }

  late List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Expanded(
        child: Container(
          child: Text(dataGridCell.value.toString()),
        ),
      );
    }).toList());
  }
}
