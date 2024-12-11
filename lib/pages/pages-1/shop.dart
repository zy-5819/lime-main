import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:lime/pages/pages-1/drag.dart';

class ShopData {
  final List<Offset> positiones;
  final int index;
  final Function(int, int, Widget) itemBuilder;
  final ValueListenable<bool> valueListenable;
  final void Function() onLongPress;
  final bool isSave;

  ShopData(this.isSave,
      {required this.positiones,
      required this.index,
      required this.itemBuilder,
      required this.valueListenable,
      required this.onLongPress});
}

class ShopModule extends StatefulWidget {
  final ShopData data;
  const ShopModule({Key? key, required this.data}) : super(key: key);
  @override
  State<ShopModule> createState() => _ShopModuleState();
}

class _ShopModuleState extends State<ShopModule> with TickerProviderStateMixin {
  late TextEditingController _textController;

  bool _fontSizeFlage = false;
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
        title: Text('添加店家'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(ShopItem(
                  currentShopItemLisener: currentShopItem,
                    onTap: (index) {
                      setState(() {
                        //_children.removeAt(index);
                      });
                    },
                    text: _textController.text,
                    color: Colors.pink,
                    positiones: widget.data.positiones,
                    isLast: true,
                    index: widget.data.index + 1,
                    itemBuilder: widget.data.itemBuilder,
                    valueListenable: widget.data.valueListenable,
                    onLongPress: widget.data.onLongPress));
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
                    Text('商家名称：'),
                    Expanded(
                        child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(hintText: '请输入表头组件名称'),
                    ))
                  ],
                ),
                // Row(
                //   children: [
                //     Text('类型：'),
                //     DropdownButton(
                //         icon: Icon(Icons.arrow_right),
                //         iconSize: 40,
                //         iconEnabledColor: Colors.grey.withOpacity(0.7),
                //         hint: Text('请选择类型'),
                //         items: [
                //           DropdownMenuItem(child: Text('文本'), value: 1),
                //           DropdownMenuItem(child: Text('数字'), value: 2),
                //           DropdownMenuItem(child: Text('时间'), value: 3)
                //         ],
                //         onChanged: (value) {})
                //   ],
                // ),
              ],
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   constraints: BoxConstraints(minHeight: 50.h),
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.all(Radius.circular(20.r))),
          //   margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text('默认值：'),
          //       Wrap(
          //         children: [
          //           Text('data'),
          //           SizedBox(
          //             height: 100,
          //             width: 100,
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ]),
      )),
    );
  }
}
