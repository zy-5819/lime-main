import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/main.dart';

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
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      child: Material(
        child: Calculator(
          onCommit: onCommit,
          onDel: onDel,
        ),
      ),
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
  overlayEntry?.remove();
  overlayEntry = null;
}

class Book extends StatelessWidget {
  const Book({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // const App();
        Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        numberKeypan(context: context);
      }),
    );
  }
}

class Calculator extends StatefulWidget {
  final Function? onCommit;
  final Function? onDel;
  const Calculator({Key? key, this.onCommit, this.onDel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _calculatorState();
}

class _calculatorState extends State<Calculator> {
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
    'C',
    '0',
    '.'
  ];
  String _input = '';
  String _result = '';
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
    _textEditingController.dispose();
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        _calculateResult();
      } else if (value == 'C') {
        _input = '';
        _result = '';
      } else {
        _input += value;
      }
      _textEditingController.text = _input;
    });
  }

  void _calculateResult() {
    try {
      // 使用 expressions 包来解析和计算表达式
      final expression = Expression.parse(_input);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      _result = result.toString();
    } catch (e) {
      _result = '错误';
    }
    _textEditingController.text = _result;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //print(MediaQuery.of(context).viewInsets.bottom);
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 50,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          hintText: '请输入药品拼音首字母',
                        ),
                        focusNode: _focusNode,
                        enableSuggestions: false,
                        showCursor: true,
                        readOnly: false,
                        onTap: () {},
                        onSubmitted: (value) {},
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _focusNode.unfocus();
                    },
                    child: Container(
                        width: 60,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.mic, color: Color(0xFF6D7380)),
                          ],
                        )),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 1,
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_focusNode);
                    },
                    child: Container(
                        width: 60,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.keyboard_hide_sharp,
                                color: Color(0xFF6D7380)),
                          ],
                        )),
                  )
                ],
              )),
          AnimatedContainer(
            curve: const Cubic(0.160, 0.265, 0.125, 0.995),
            duration: const Duration(seconds: 5),
            height: MediaQuery.of(context).viewInsets.bottom > 0 ||
                    _focusNode.hasFocus
                ? 0
                : null,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 50 * 1.5,
                          child: MaterialButton(
                            onPressed: () {
                              widget.onDel?.call();
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
                              widget.onCommit?.call();
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
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: List.generate(list.length, (index) {
                          return Ink(
                            color: Colors.white,
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.25),
                                ),
                                alignment: Alignment.center,
                                height: 50,
                                width: (MediaQuery.of(context).size.width -
                                        60 -
                                        80.w) /
                                    3,
                                child: Text(
                                  list[index],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onTap: () {
                                if (list[index] != "C") {
                                  _onButtonPressed(list[index]);
                                } else {
                                  _input = "";
                                  _textEditingController.text = _input;
                                }
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 80.w,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 80.w,
                            height: 50 * 1.5,
                            child: MaterialButton(
                              onPressed: () {
                                widget.onDel?.call();
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
                          Container(
                            //color: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Wrap(
                              spacing: 5.w,
                              runSpacing: 15.h,
                              children: [
                                new Ink(
                                  //用ink圆角矩形
                                  // color: Colors.red,
                                  decoration: new BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle,

                                    //设置圆角
                                  ),
                                  child: new InkWell(
                                    splashColor: Colors.blue,
                                    //圆角设置,给水波纹也设置同样的圆角
                                    //如果这里不设置就会出现矩形的水波纹效果
                                    borderRadius: BorderRadius.circular(30.sp),
                                    onTap: () {},
                                    child: Container(
                                      width: 30.sp,
                                      height: 30.sp,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                                                new Ink(
                                  //用ink圆角矩形
                                  // color: Colors.red,
                                  decoration: new BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle,

                                    //设置圆角
                                  ),
                                  child: new InkWell(
                                    splashColor: Colors.blue,
                                    //圆角设置,给水波纹也设置同样的圆角
                                    //如果这里不设置就会出现矩形的水波纹效果
                                    borderRadius: BorderRadius.circular(30.sp),
                                    onTap: () {},
                                    child: Container(
                                      width: 30.sp,
                                      height: 30.sp,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),

                                // ElevatedButton(
                                //   style: ElevatedButton.styleFrom(
                                //       minimumSize: Size.fromRadius(15.sp),
                                //       shape: CircleBorder(),
                                //       padding: EdgeInsets.zero),
                                //   onPressed: () {
                                //     // 按钮点击后的操作
                                //     print('圆形按钮被点击了！');
                                //   },
                                //   child: Text('+'),
                                // ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: MaterialButton(
                            onPressed: () {
                              // disKeypan();
                              widget.onCommit?.call();
                            },
                            color: Colors.blue,
                            child: const Text(
                              "回车",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class CalculatorResult extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorResult> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        _calculateResult();
      } else if (value == 'C') {
        _input = '';
        _result = '';
      } else {
        _input += value;
      }
    });
  }

  void _calculateResult() {
    try {
      // 使用 expressions 包来解析和计算表达式
      final expression = Expression.parse(_input);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      _result = result.toString();
    } catch (e) {
      _result = '错误';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简单计算器'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _input,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('/'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('*'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('C'),
                      _buildButton('0'),
                      _buildButton('='),
                      _buildButton('+'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(value),
      child: Text(value, style: TextStyle(fontSize: 24)),
    );
  }
}
