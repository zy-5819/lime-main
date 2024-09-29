import 'package:flutter/material.dart';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/rendering.dart';

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
  const DataTable2SimpleDemo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Table(),
    );
  }
}

class Table extends StatefulWidget {
  @override
  _TableState createState() => _TableState();
}

class _TableState extends State<Table> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          smRatio: 0,
          dividerThickness: 0,
          columns: [
            DataColumn2(
              label: Text('Column A'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Column B'),
            ),
            DataColumn(
              label: Text('Column C'),
            ),
            DataColumn(
              label: Text('Column D'),
            ),
            DataColumn(
              label: Text('Column NUMBERS'),
              numeric: true,
            ),
          ],
          rows: List<DataRow>.generate(
              2,
              (index) => DataRow(cells: [
                    DataCell(EditableTextExample()),
                    DataCell(Text('B' * (10 - (index + 5) % 10))),
                    DataCell(Text('C' * (15 - (index + 5) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text(((index + 0.1) * 25.4).toString()))
                  ])));
  }
}

class EditableTextExample extends StatefulWidget {
  @override
  _EditableTextExampleState createState() => _EditableTextExampleState();
}

class _EditableTextExampleState extends State<EditableTextExample> {
  final TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'afasdfa',
        border: InputBorder.none,
      ),
      controller: _controller,
      focusNode: _focusNode,
      style: TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.blue,
      onSubmitted: (String value) {
        // 提交时的操作
        print('Submitted: $value');
      },
    );
  }
}
