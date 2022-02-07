import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final String tableStationery = 'stationery';

class StationeryFields {
  static final List<String> values = [id, name, quantity, employee, dateTime];

  static final String id = '_id';
  static final String name = 'name';
  static final String quantity = 'quantity';
  static final String employee = 'employee';
  static final String dateTime = 'dateTime';
}

class Stationery {
  final int id;
  final String name;
  final int quantity;
  final String employee;
  final DateTime dateTime;

  Stationery(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.employee,
      required this.dateTime});

  Stationery copy(
          {int? id,
          String? name,
          int? quantity,
          String? employee,
          DateTime? dateTime}) =>
      Stationery(
          id: id ?? this.id,
          name: name ?? this.name,
          quantity: quantity ?? this.quantity,
          employee: employee ?? this.employee,
          dateTime: dateTime ?? this.dateTime);
}

class ProjectorDataSource extends DataGridSource {
  ProjectorDataSource(List<Stationery> projectors) {
    dataGridRows = projectors
        .map((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<int>(
                  columnName: 'quantity', value: dataGridRow.quantity),
              DataGridCell<String>(
                  columnName: 'employee', value: dataGridRow.employee),
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
