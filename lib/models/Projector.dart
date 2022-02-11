import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final String tableProjector = 'projectors';

class ProjectorFields {
  static final List<String> values = [
    id,
    name,
    serialNumber,
    status,
    department,
    dateTime
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String serialNumber = 'serialNumber';
  static final String status = 'status';
  static final String department = 'department';
  static final String dateTime = 'dateTime';
}

class Projector {
  final int? id;
  final String name;
  final String serialNumber;
  final String status;
  final String department;
  final String dateTime;

  Projector(
      {this.id,
      required this.name,
      required this.serialNumber,
      required this.status,
      required this.department,
      required this.dateTime});

  Projector copy(
          {int? id,
          String? name,
          String? serialNumber,
          String? status,
          String? department,
          String? dateTime}) =>
      Projector(
          id: id ?? this.id,
          name: name ?? this.name,
          serialNumber: serialNumber ?? this.serialNumber,
          status: status ?? this.status,
          department: department ?? this.department,
          dateTime: dateTime ?? this.dateTime);

  static Projector fromJson(Map<String, Object?> json) => Projector(
      id: json[ProjectorFields.id] as int,
      name: json[ProjectorFields.name] as String,
      serialNumber: json[ProjectorFields.serialNumber] as String,
      status: json[ProjectorFields.status] as String,
      department: json[ProjectorFields.department] as String,
      dateTime: json[ProjectorFields.dateTime] as String);

  Map<String, Object?> toJson() => {
        ProjectorFields.id: id,
        ProjectorFields.name: name,
        ProjectorFields.serialNumber: serialNumber,
        ProjectorFields.status: status,
        ProjectorFields.department: department,
        ProjectorFields.dateTime: dateTime
      };
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
