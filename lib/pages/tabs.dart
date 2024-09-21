import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lime/pages/book.dart';
import 'package:lime/pages/chart.dart';
import 'package:lime/pages/dtail.dart';
import 'package:lime/pages/individual.dart';
import 'package:lime/pages/record.dart';

class BottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Tabs extends StatefulWidget {
  Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;

  List navigationBarItem = [
    Dtail(),
    Chart(),
    Record(),
    Book(),
    Demo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationBarItem[_currentIndex],
        bottomNavigationBar: ButtomBar(
          onTap: (v) {
            setState(() {
              _currentIndex = v;
            });
          },
          currentIndex: _currentIndex,
        )

        // Container(
        //   // color: Colors.pink.withAlpha(0),
        //   child:
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       InkWell(
        //         onTap: () {
        //           print('object');
        //         },
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Icon(
        //               Icons.home,
        //             ),
        //             Text('data')
        //           ],
        //         ),
        //       ),

        //       IconButton(
        //         icon: Icon(Icons.search),
        //         onPressed: () {
        //           // 导航到搜索页面
        //         },
        //       ),
        //       // 添加更多 IconButton
        //     ],
        //   ),
        // )
        //     BottomNavigationBar(
        //   onTap: (index) => {_currentIndex = index},
        //   // setState(() {
        //   //   _currentIndex = index;
        //   // }),
        //   currentIndex: _currentIndex,
        //   fixedColor: HexColor('#54C395'),
        //   type: BottomNavigationBarType.fixed,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.article),
        //       label: '明细',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.addchart),
        //       label: '报表',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.add_box_rounded,
        //         size: 60,
        //       ),
        //       backgroundColor: Colors.white,
        //       label: '',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.auto_stories,
        //       ),
        //       label: '账本',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: '我的',
        //     ),
        //   ],
        // ),
        );
  }
}

class ButtomBar extends StatefulWidget {
  final void Function(int)? onTap;
  final int? currentIndex;

  const ButtomBar({super.key, this.onTap, this.currentIndex});
  @override
  State<StatefulWidget> createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink.withAlpha(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Item(
            index: 1,
            selected: false,
            data: Icons.article,
          ),
          _Item(
            index: 2,
            selected: false,
            data: Icons.addchart,
          ),
          _Item(
            index: 3,
            selected: false,
            data: Icons.auto_stories,
          ),
          _Item(
            index: 4,
            selected: false,
            data: Icons.person,
          ),

          // 添加更多 IconButton
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final int index;
  final bool selected;
  final void Function(int)? onTap;
  final IconData data;
  final String? text;

  const _Item(
      {super.key,
      required this.index,
      required this.selected,
      this.onTap,
      required this.data,
      this.text});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(data), text != null ? Text('data') : SizedBox.shrink()],
      ),
    );
  }
}
