import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final String tableVenues = 'venues';

class VenueFields {
  static final List<String> values = [
    id,
    name,
    bookedBy,
    nameOfEvent,
    status,
    dateTime
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String bookedBy = 'bookedBy';
  static final String nameOfEvent = 'nameOfEvent';
  static final String status = 'status';
  static final String dateTime = 'dateTime';
}

class Venue {
  final int? id;
  final String name;
  final String bookedBy;
  final String nameOfEvent;
  final String status;
  final String dateTime;

  Venue(
      {this.id,
      required this.name,
      required this.bookedBy,
      required this.nameOfEvent,
      required this.status,
      required this.dateTime});

  Venue copy({
    int? id,
    String? name,
    String? bookedBy,
    String? nameOfEvent,
    String? status,
    String? dateTime,
  }) =>
      Venue(
          id: id ?? this.id,
          name: name ?? this.name,
          bookedBy: bookedBy ?? this.bookedBy,
          nameOfEvent: nameOfEvent ?? this.nameOfEvent,
          status: status ?? this.status,
          dateTime: dateTime ?? this.dateTime);

  static Venue fromJson(Map<String, dynamic> json) => Venue(
      id: json[VenueFields.id] as int,
      name: json[VenueFields.name] as String,
      bookedBy: json[VenueFields.bookedBy] as String,
      nameOfEvent: json[VenueFields.nameOfEvent] as String,
      status: json[VenueFields.status] as String,
      dateTime: json[VenueFields.dateTime] as String);

  Map<String, dynamic> toJson() => {
        VenueFields.id: id,
        VenueFields.name: name,
        VenueFields.bookedBy: bookedBy,
        VenueFields.nameOfEvent: nameOfEvent,
        VenueFields.status: status,
        VenueFields.dateTime: dateTime,
      };
}

class VenueDataSource extends DataGridSource {
  VenueDataSource(List<Venue> venues) {
    dataGridRows = venues
        .map((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'bookedBy', value: dataGridRow.bookedBy),
              DataGridCell<String>(
                  columnName: 'nameOfEvent', value: dataGridRow.nameOfEvent),
              DataGridCell<String>(
                  columnName: 'status', value: dataGridRow.status),
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
