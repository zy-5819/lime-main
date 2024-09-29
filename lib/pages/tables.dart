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
  late List<DataColumn> columns;
  late List<DataRow> rows;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    columns = [
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
    ];
    rows = [
      DataRow(cells: [
        DataCell(EditableTextExample()),
        DataCell(EditableTextExample(
          text: '22',
        )),
        DataCell(Text('C')),
        DataCell(Text('D')),
        DataCell(Text('25.4')),
      ]),
      DataRow(cells: [
        DataCell(EditableTextExample()),
        DataCell(Text('B')),
        DataCell(Text('C')),
        DataCell(Text('D')),
        DataCell(Text('25.4')),
      ])
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            rows.add(DataRow(cells: [
              DataCell(EditableTextExample()),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]));
          });
        },
      ),
      body: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          smRatio: 0,
          dividerThickness: 0,
          columns: columns,
          rows: rows),
    );
  }
}

class EditableTextExample extends StatefulWidget {
  final String? text;

  const EditableTextExample({super.key, this.text});
  @override
  _EditableTextExampleState createState() => _EditableTextExampleState();
}

class _EditableTextExampleState extends State<EditableTextExample> {
  final TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.text ?? '';
    _focusNode.addListener(() {
      // 当焦点状态变化时调用
      if (_focusNode.hasFocus) {
        if (_controller.text.isNotEmpty) {
          _focusNode.nextFocus();
        }
        // 这里可以处理获取焦点的逻辑
      } else {
        print('TextField lost focus');
        // 这里可以处理失去焦点的逻辑
      }
    });
  }

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
      onEditingComplete: () {
        _focusNode.nextFocus();
      },
      onSubmitted: (String value) {
        // 提交时的操作
        print('Submitted: $value');
      },
      onTap: () {
        print('Tap');
      },
    );
  }
}
