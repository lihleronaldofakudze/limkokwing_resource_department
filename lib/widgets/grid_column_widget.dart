import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

GridColumn gridColumnWidget(
    {required String columnName, required String text}) {
  return GridColumn(
      columnWidthMode: ColumnWidthMode.fill,
      columnName: columnName,
      label: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white),
        ),
      ));
}
