import 'package:flutter/material.dart';
import 'package:lime/pages/drag.dart';

/// <summary>
/// todo: 数字键盘
/// author：zwb
/// dateTime：2021/7/19 10:25
/// filePath：lib/app/widgets/number_keypan.dart
/// desc:
/// <summary>
OverlayEntry? overlayEntry;
numberKeypan({
  //required Function(String) onTap,
  required BuildContext context,
  Function? onCommit,
  Function? onDel,
}) {
  overlayEntry = OverlayEntry(builder: (context) {
    List<String> list = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '',
      '0',
      '.'
    ];
    return AnimatedContainer(
      curve: const Cubic(0.160, 0.265, 0.125, 0.995),
      duration: const Duration(milliseconds: 360),
      child: Positioned(
          bottom: 0,
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(list.length, (index) {
                        return Material(
                          color: Colors.white,
                          child: Ink(
                            color: Colors.white,
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.25),
                                ),
                                alignment: Alignment.center,
                                height: 50,
                                width:
                                    (MediaQuery.of(context).size.width - 60) /
                                        3,
                                child: Text(
                                  list[index],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onTap: () {
                                if (list[index] != "") {
                                  //onTap(list[index]);
                                }
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 50 * 1.5,
                        child: MaterialButton(
                          onPressed: () {
                            if (onDel != null) {
                              onDel();
                            }
                          },
                          color: Colors.grey[100],
                          elevation: 0,
                          padding: const EdgeInsets.all(0),
                          child: const Text("删除",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 50 * 2.5,
                        child: MaterialButton(
                          onPressed: () {
                            // disKeypan();
                            if (onCommit != null) {
                              onCommit();
                            }
                          },
                          color: Colors.blue,
                          elevation: 0,
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            "回车",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  });
  openKeypan(context: context);
}

/// <summary>
/// todo: 保持光标在最后
/// author: zwb
/// date: 2021/7/19 11:43
/// param: 参数
/// return: void
/// <summary>
///
lastCursor({required TextEditingController textEditingController}) {
  /// 保持光标在最后
  final length = textEditingController.text.length;
  textEditingController.selection =
      TextSelection(baseOffset: length, extentOffset: length);
}

/// <summary>
/// todo: 自定义键盘的删除事件
/// author: zwb
/// date: 2021/7/19 11:45
/// param: 参数
/// return: void
/// <summary>
///
delCursor({required TextEditingController textEditingController}) {
  if (textEditingController.value.text != "") {
    textEditingController.text = textEditingController.text
        .substring(0, textEditingController.text.length - 1);
  }
}

/// <summary>
/// todo: 打开键盘
/// author: zwb
/// date: 2021/7/19 12:04
/// param: 参数
/// return: void
/// <summary>
///
openKeypan({BuildContext? context}) {
  Overlay.of(context!).insert(overlayEntry!);
}

/// <summary>
/// todo: 销毁键盘
/// author: zwb
/// date: 2021/7/19 12:03
/// param: 参数
/// return: void
/// <summary>
///
disKeypan() {
  overlayEntry!.remove();
}

class Book extends StatelessWidget {
  const Book({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const App();
//     Column(
//       children: [
//             Container(
//         height: 50,
//         color: Colors.white,
//         child: Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: '请输入药品拼音首字母',
//                   ),
//                   focusNode: null,
//                   showCursor: true,
//                   readOnly: true,
//                   onTap: () {
//                     numberKeypan(context: context);
//                   },
//                   onSubmitted: (value) {},
//                   onChanged: (value) {},
//                 ),
//               ),
//             ),
//             Container(
//               //color: WMColor.divider,
//               width: 0.5,
//               height: 40,
//             ),
//             GestureDetector(
//               child: Container(
//                   width: 60,
//                   height: 50,
//                   alignment: Alignment.center,
//                   // color: Colors.red,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.keyboard_sharp, color: Color(0xFF6D7380)),
//                       IconButton(
//                         icon: Icon(
//                           Icons.keyboard_arrow_down,
//                         ),
//                         onPressed: () {},
//                       ),
//                     ],
//                   )),
//             )
//           ],
//         )),
//         Container(
//       child: AnimatedContainer(
//         curve: Cubic(0.160, 0.265, 0.125, 0.995),
//         duration: Duration(milliseconds: 360),
//         height:
//                  250,

//         child: Container(
//           // height: keyBoardType == 1 ? 250 : 380,
//           alignment: Alignment.topCenter,
//           child: Column(
//             children: [

//             ],
//           ),
//         ),
//       ),
//     )
// ],
//     );
  }
}
