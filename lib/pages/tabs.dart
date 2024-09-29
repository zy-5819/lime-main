import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lime/pages/book.dart';
import 'package:lime/pages/chart.dart';
import 'package:lime/pages/drag.dart';
import 'package:lime/pages/dtail.dart';
import 'package:lime/pages/image.dart';
import 'package:lime/pages/individual.dart';
import 'package:lime/pages/record.dart';
import 'package:lime/pages/tables.dart';

final GlobalKey barKey = GlobalKey();

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;

  List navigationBarItem = [
    DataTable2SimpleDemo(),
    const Chart(),
    Record(),
    const Book(),
    const Demo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationBarItem[_currentIndex],
        bottomNavigationBar: ButtomBar(
          key: barKey,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Item(
          text: '明细',
          index: 0,
          selected: widget.currentIndex == 0,
          data: Icons.article,
          onTap: widget.onTap,
        ),
        _Item(
          text: '报表',
          index: 1,
          selected: widget.currentIndex == 1,
          data: Icons.addchart,
          onTap: widget.onTap,
        ),
        _Item(
          index: 2,
          selected: widget.currentIndex == 2,
          data: Icons.add_box_rounded,
          onTap: widget.onTap,
          isAdd: true,
        ),
        _Item(
          text: '账本',
          index: 3,
          selected: widget.currentIndex == 3,
          data: Icons.auto_stories,
          onTap: widget.onTap,
        ),
        _Item(
          text: '我的',
          index: 4,
          selected: widget.currentIndex == 4,
          data: Icons.person,
          onTap: widget.onTap,
        ),

        // 添加更多 IconButton
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final int index;
  final bool selected;
  final void Function(int)? onTap;
  final IconData data;
  final String? text;
  final bool isAdd;

  const _Item(
      {required this.index,
      required this.selected,
      this.onTap,
      required this.data,
      this.text,
      this.isAdd = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call(index);
      },
      child: isAdd
          ? Icon(
              data,
              size: selected ? 55 : 50,
              color: HexColor('#54C395'),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  data,
                  size: selected ? 25 : 20,
                  color: selected ? HexColor('#54C395') : Colors.grey,
                ),
                text != null
                    ? Text(
                        text!,
                        style: TextStyle(
                            color: selected ? HexColor('#54C395') : Colors.grey,
                            fontSize: selected ? 16 : 14),
                      )
                    : const SizedBox.shrink()
              ],
            ),
    );
  }
}
