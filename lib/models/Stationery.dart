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
  final int? id;
  final String name;
  final int quantity;
  final String employee;
  final String dateTime;

  Stationery(
      {this.id,
      required this.name,
      required this.quantity,
      required this.employee,
      required this.dateTime});

  Stationery copy(
          {int? id,
          String? name,
          int? quantity,
          String? employee,
          String? dateTime}) =>
      Stationery(
          id: id ?? this.id,
          name: name ?? this.name,
          quantity: quantity ?? this.quantity,
          employee: employee ?? this.employee,
          dateTime: dateTime ?? this.dateTime);

  static Stationery fromJson(Map<String, dynamic> json) => Stationery(
      id: json[StationeryFields.id] as int,
      name: json[StationeryFields.name] as String,
      quantity: json[StationeryFields.quantity] as int,
      employee: json[StationeryFields.employee] as String,
      dateTime: json[StationeryFields.dateTime] as String);

  Map<String, dynamic> toJson() => {
        StationeryFields.id: id,
        StationeryFields.name: name,
        StationeryFields.quantity: quantity,
        StationeryFields.employee: employee,
        StationeryFields.dateTime: dateTime,
      };
}

class StationeryDataSource extends DataGridSource {
  StationeryDataSource(List<Stationery> projectors) {
    dataGridRows = projectors
        .map((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<int>(
                  columnName: 'quantity', value: dataGridRow.quantity),
              DataGridCell<String>(
                  columnName: 'employee', value: dataGridRow.employee),
              DataGridCell<String>(
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
      return Container(
        alignment: Alignment.center,
        child: Text(
          dataGridCell.value.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
      );
    }).toList());
  }
}
