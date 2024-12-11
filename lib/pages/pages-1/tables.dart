import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:lime/pages/pages-1/book.dart';
import 'package:lime/pages/pages-1/drag.dart';
import 'package:lime/pages/pages-1/voice_message_widget.dart';

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
  final SubModuleData data;
  final String shopName;
  const DataTable2SimpleDemo(
      {super.key, required this.data, required this.shopName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$shopName的记账'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            disKeypan();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                numberKeypan(context: context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).nextFocus();
          FocusNode currentFocus = FocusScope.of(context).focusedChild!;
          var y = currentFocus.context
              ?.findAncestorStateOfType<EditableTextExampleState>();
          y?.test();
          var x = 1;
        },
      ),
      body: Table(
        data: data,
      ),
    );
  }
}

class Table extends StatefulWidget {
  final SubModuleData data;

  const Table({super.key, required this.data});
  @override
  _TableState createState() => _TableState();
}

class _TableState extends State<Table> {
  late List<DataColumn> columns;
  late List<DataRow> rows;
  late FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      numberKeypan(context: context, focusNode: _focusNode);
    });
    columns = widget.data.datas
        .map((e) => DataColumn2(size: ColumnSize.M, label: Text(e.name)))
        .toList();
    rows = List.generate(
        100,
        (v) => DataRow(cells: [
              DataCell(EditableTextExample(
                onTap: (node) {
                  setState(() {
                    _focusNode = node;
                  });
                },
                text: '番茄',
              )),
              DataCell(
                EditableTextExample(
                  onTap: (node) {
                    setState(() {
                      _focusNode = node;
                    });
                  },
                ),
              ),
              DataCell(EditableTextExample(
                onTap: (node) {
                  setState(() {
                    _focusNode = node;
                  });
                },
              )),
            ])).toList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: VoiceCommandButton(
          data: widget.data,
          onResult: (v) {
            setState(() {
              rows.add(DataRow(
                  cells: v
                      .map((e) => DataCell(EditableTextExample(
                            text: e,
                            onTap: (node) {
                              setState(() {
                                _focusNode = node;
                              });
                            },
                          )))
                      .toList()));
            });
          }),
      body: GestureDetector(
        child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            smRatio: 0,
            dividerThickness: 0,
            columns: columns,
            rows: rows),
        onTap: disKeypan,
      ),
    );
  }
}

class EditableTextExample extends StatefulWidget {
  final String? text;
  final Function(FocusNode node)? onTap;

  const EditableTextExample({super.key, this.text, this.onTap});
  @override
  EditableTextExampleState createState() => EditableTextExampleState();
}

class EditableTextExampleState extends State<EditableTextExample> {
  // final TextEditingController _controller = TextEditingController();
  // FocusNode _focusNode = FocusNode();

  String tt = 'sss';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.text = widget.text ?? '';
    // _focusNode.addListener(() {
    //   // 当焦点状态变化时调用
    //   if (_focusNode.hasFocus) {
    //     if (_controller.text.isNotEmpty) {
    //       _focusNode.nextFocus();
    //     }
    //     // 这里可以处理获取焦点的逻辑
    //   } else {
    //     print('TextField lost focus');
    //     // 这里可以处理失去焦点的逻辑
    //   }
    // });
  }

  void test() {
    setState(() {
      tt = '234234';
      print(tt);
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    // _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: tt,
        border: InputBorder.none,
      ),
      // controller: _controller,
      // focusNode: _focusNode,

      style: TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.blue,
      onEditingComplete: () {
        //_focusNode.nextFocus();
      },
      onChanged: (value) {
        setState(() {
          tt = value;
        });
        print(tt); // 监听文本变化并更新状态
      },
      onTap: () {
        //widget.onTap?.call(_focusNode);
        print('Tap');
      },
    );
  }
}

class DataCellPlus extends DataCell {
  const DataCellPlus(super.child);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: child,
    );
  }
}
