import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final String tableLaptop = 'laptops';

class LaptopFields {
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

class Laptop {
  final int id;
  final String name;
  final String serialNumber;
  final String status;
  final String department;
  final DateTime dateTime;

  Laptop(
      {required this.id,
      required this.name,
      required this.serialNumber,
      required this.status,
      required this.department,
      required this.dateTime});

  Laptop copy(
          {int? id,
          String? name,
          String? serialNumber,
          String? status,
          String? department,
          DateTime? dateTime}) =>
      Laptop(
          id: id ?? this.id,
          name: name ?? this.name,
          serialNumber: serialNumber ?? this.serialNumber,
          status: status ?? this.status,
          department: department ?? this.department,
          dateTime: dateTime ?? this.dateTime);

  static Laptop fromJson(Map<String, Object?> json) => Laptop(
      id: json[LaptopFields.id] as int,
      name: json[LaptopFields.name] as String,
      serialNumber: json[LaptopFields.serialNumber] as String,
      status: json[LaptopFields.status] as String,
      department: json[LaptopFields.department] as String,
      dateTime: json[LaptopFields.dateTime] as DateTime);

  Map<String, Object?> toJson() => {
        LaptopFields.id: id,
        LaptopFields.name: name,
        LaptopFields.serialNumber: serialNumber,
        LaptopFields.status: status,
        LaptopFields.department: department,
        LaptopFields.dateTime: dateTime
      };
}

class LaptopDataSource extends DataGridSource {
  LaptopDataSource(List<Laptop> projectors) {
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
