import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final String tableAdmin = 'admins';

class AdminFields {
  static final List<String> values = [id, username, password];

  static final String id = 'id';
  static final String username = 'username';
  static final String password = 'password';
}

class Admin {
  final int? id;
  final String username;
  final String password;

  Admin({this.id, required this.username, required this.password});

  Admin copy({int? id, String? username, String? password}) => Admin(
      username: username ?? this.username, password: password ?? this.password);

  static Admin fromJson(Map<String, dynamic> json) => Admin(
      id: json[AdminFields.id] as int,
      username: json[AdminFields.username] as String,
      password: json[AdminFields.password] as String);

  Map<String, dynamic> toJson() => {
        AdminFields.id: id,
        AdminFields.username: username,
        AdminFields.password: password,
      };
}

class AdminDataSource extends DataGridSource {
  AdminDataSource(List<Admin> admins) {
    dataGridRows = admins
        .map((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: 'username', value: dataGridRow.username),
              DataGridCell<String>(
                  columnName: 'id', value: dataGridRow.password),
            ]))
        .toList();
  }

  late List<DataGridRow> dataGridRows;

  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    throw DataGridRowAdapter(
        cells: row.getCells().map((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          dataGridCell.value,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
      );
    }).toList());
  }
}
