import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:lime/pages/pages-1/drag.dart';

class TableItmeModuleData {
  final bool isSave;

  TableItmeModuleData(
    this.isSave,
  );
}

class TableItmeModule extends StatefulWidget {
  final TableItmeModuleData data;
  const TableItmeModule({Key? key, required this.data}) : super(key: key);
  @override
  State<TableItmeModule> createState() => _TableItmeModuleState();
}

class _TableItmeModuleState extends State<TableItmeModule>
    with TickerProviderStateMixin {
  late TextEditingController _textController;
  CellType _cellType = CellType.text;
  late List<dynamic> _values;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _values = [];
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#fafafa'),
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 27,
        elevation: 1,
        backgroundColor: HexColor('#fafafa'),
        title: Text('添加表头'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(TableItemData(
                  Random().nextDouble().toString(),
                  name: _textController.text,
                  type: _cellType,
                  data: _values,
                ));
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('表头组件名称：'),
                    Expanded(
                        child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(hintText: '请输入表头组件名称'),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text('类型：'),
                    DropdownButton(
                        icon: Icon(Icons.arrow_right),
                        iconSize: 40,
                        value: _cellType,
                        iconEnabledColor: Colors.grey.withOpacity(0.7),
                        hint: Text('请选择类型'),
                        items: [
                          DropdownMenuItem<CellType>(
                              child: Text('文本'), value: CellType.text),
                          DropdownMenuItem<CellType>(
                              child: Text('数字'), value: CellType.number),
                          DropdownMenuItem<CellType>(
                              child: Text('时间'), value: CellType.DateTime)
                        ],
                        onChanged: (value) {
                          setState(() {
                            _cellType = value as CellType;
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 50.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('默认值：'),
                Wrap(
                  children: [
                    Text('data'),
                    SizedBox(
                      height: 100,
                      width: 100,
                    )
                  ],
                )
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
