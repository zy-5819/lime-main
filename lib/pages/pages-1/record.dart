import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lime/pages/pages-1/drag.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
        backgroundColor: HexColor('#fafafa'),
        foregroundColor: HexColor('#000000'),
        elevation: 1,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          child: const Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('选择模板'),
            ],
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Theme.of(context).colorScheme.primary,
          tabs: [
            Text(
              '入库',
              style: TextStyle(
                fontSize: 17,
                color: HexColor('#333333'),
              ),
            ),
            Text(
              '出库',
              style: TextStyle(
                fontSize: 17,
                color: HexColor('#333333'),
              ),
            ),
          ],
        ),
        // actions: [
        //   InkWell(
        //     onTap: (() {
        //       Navigator.of(context).pop();
        //     }),
        //     child: Container(
        //       margin: const EdgeInsets.only(right: 16),
        //       alignment: Alignment.center,
        //       child: const Text('取消'),
        //     ),
        //   ),
        // ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          App(),
          App(),
        ],
      ),
    );
  }
}
