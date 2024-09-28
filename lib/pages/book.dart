import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:bubble_box/bubble_box.dart';
import 'package:expressions/expressions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lime/pages/individual.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vibration/vibration.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

class OverlayTooltip extends StatefulWidget {
  @override
  _OverlayTooltipState createState() => _OverlayTooltipState();
}

class _OverlayTooltipState extends State<OverlayTooltip> {
  // 用于控制Overlay的显示
  bool _isVisible = false;

  // 记录点击位置的全局键
  final GlobalKey _overlayKey = GlobalKey();

  // 处理点击事件
  void _handleTap() {
    // 可以在这里添加其他逻辑，比如记录点击位置等
    setState(() {
      _isVisible = true;
    });

    // 可以设置一个定时器来自动隐藏提示
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 你的主要内容，这里是一个可点击的按钮
        Positioned(
          key: _overlayKey,
          child: ElevatedButton(
            onPressed: _handleTap,
            child: Text('点击我'),
          ),
        ),
        // Overlay用于显示提示
        if (_isVisible)
          Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Positioned(
                  // 根据需要调整位置
                  top: (_overlayKey.currentContext?.findRenderObject()
                              as RenderBox)
                          .localToGlobal(Offset.zero)
                          .dy ??
                      0.0 - 50.0, // 假设向上偏移50
                  left: (_overlayKey.currentContext?.findRenderObject()
                              as RenderBox)
                          .localToGlobal(Offset.zero)
                          .dx ??
                      0.0,
                  child: Material(
                    elevation: 4.0,
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('这是一个提示！',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
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
      body: GestureDetector(
        onTap: () {
          disKeypan();
        },
        // child: MyApp(),
      ),
    );
  }
}

class LongPressColorChangeWidget extends StatefulWidget {
  final void Function(bool isSpeeching) onTap;
  final void Function(String text) onCommit;
  const LongPressColorChangeWidget(
      {super.key, required this.onTap, required this.onCommit});

  @override
  createState() => _LongPressColorChangeWidgetState();
}

class _LongPressColorChangeWidgetState extends State<LongPressColorChangeWidget>
    with SingleTickerProviderStateMixin {
  late bool _isCancel;
  final _recorder = FlutterSoundRecorder();
  bool _isLongPressed = false;
  OverlayEntry? overlayEntry;
  Codec _codec = Codec.pcm16;
  StreamSubscription<Uint8List>? _dataSubscription;
  final _textController = ValueNotifier('');
  final _data = <int>[];
  numberKeypan({
    //required Function(String) onTap,
    required BuildContext context,
    Function? onCommit,
    Function? onDel,
  }) {
    overlayEntry = OverlayEntry(
      builder: (context) {
        var box = _overlayKey.currentContext?.findRenderObject() as RenderBox;
        return Positioned(
          // 根据需要调整位置
          top: box.localToGlobal(Offset.zero).dy - 200.h, // 假设向上偏移50
          child: Material(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 200.h,
                width: 1.sw,
              ),
              BubbleBox(
                maxWidth: 0.8.sw,
                shape: BubbleShapeBorder(
                  radius: BorderRadius.all(Radius.circular(15.r)),
                  direction: BubbleDirection.bottom,
                  position: BubblePosition.center(
                      box.localToGlobal(Offset.zero).dx - 0.5.sw + 30.w),
                  arrowQuadraticBezierLength: 1,
                ),
                backgroundColor: Colors.blue,
                margin: const EdgeInsets.all(4),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  width: double.infinity,
                  child: Column(
                    children: [
                      ValueListenableBuilder<String>(
                          valueListenable: _textController,
                          builder: (context, value, child) {
                            return Text(
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                              value,
                              style: const TextStyle(color: Colors.white),
                            );
                          }),
                      RecodingButton(
                        isEnabled: true,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
        );
      },
    );
    Overlay.of(context).insert(overlayEntry!);
  }

  // 记录点击位置的全局键
  final GlobalKey _overlayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initRecorder();
    _isCancel = false;
  }

  Future<void> _initializeExample() async {
    await _recorder.setSubscriptionDuration(const Duration(milliseconds: 70));
    await initializeDateFormatting();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _recorder.openRecorder();

    if (!await _recorder.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
    }
  }

  /// 请求录音权限并开启录音器
  Future<void> _initRecorder() async {
    await openTheRecorder();
    await _initializeExample();

    // if ((!kIsWeb) && Platform.isAndroid) {
    //   await copyAssets();
    // }

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  /// 长按结束后结束录音
  Future<void> _onLongPressEnd(LongPressEndDetails details) async {
    try {
      List<int> chunkSize = [5, 10, 5];
      Map<String, dynamic> request = {
        "chunk_size": chunkSize,
        "wav_name": "microphone",
        "is_speaking": false,
        "chunk_interval": 10,
        "mode": '2pass',
      };
      channel?.sink.add(jsonEncode(request));
      await _recorder.stopRecorder();
      if (_dataSubscription != null) {
        await _dataSubscription!.cancel();
        _dataSubscription = null;
      }
      widget.onCommit.call(_textController.value);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _hapticFeedback() async {
    if (Platform.isAndroid && await Vibration.hasVibrator() == true) {
      await Vibration.vibrate(duration: 15);
    } else if (Platform.isIOS) {
      await HapticFeedback.selectionClick();
    }
  }

  /// 长按打开录音界面
  Future<void> _onLongPress() async {
    if (kDebugMode) {
      print('on long press.');
    }
    try {
      try {
        unawaited(_hapticFeedback());
      } finally {}
      text = '';
      _textController.value = '';
      await _record();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      await _recorder.stopRecorder();
    }
  }

  WebSocketChannel? channel;
  String text = '';
  Future<void> connectToWebSocket() async {
    // 连接到WebSocket服务器
    channel = IOWebSocketChannel.connect('ws://192.168.1.7:10095');
    await channel?.ready.then((_) {
      List<int> chunkSize = [5, 10, 5];
      Map<String, dynamic> request = {
        "mode": '2pass',
        "chunk_size": chunkSize,
        "wav_name": "microphone",
        "is_speaking": true,
        "chunk_interval": 10,
        "itn": true,
        "hotwords": '{"阿里巴巴":20,"hello world":40}'
      };
      print(jsonEncode(request));
      channel?.sink.add(jsonEncode(request));
      print('Connection established');
      channel?.stream.listen((message) {
        // 处理从服务器接收到的消息
        print('Received: $message');
        getJsonMessage(jsonDecode(message));
      }, onError: (error) {
        print('WebSocket Error: $error');
      }, onDone: () {
        print('WebSocket done');
      });
    });
  }

  void getJsonMessage(dynamic jsonMsg) {
    String rectxt = "${jsonMsg['text']}";
    var asrmodel = jsonMsg['stamp_sents'];
    //bool is_final = jsonMsg['is_final'];
    if (asrmodel != null) {
      text = text + rectxt;
      _textController.value = text;
    } else {
      _textController.value =
          _textController.value + rectxt; //.replace(/ +/g,"");
    }
  }

  /// 开始录音
  Future<void> _record() async {
    try {
      connectToWebSocket();
      final streamController = StreamController<Uint8List>();
      _data.clear();
      _dataSubscription = streamController.stream.listen((v) {
        print('Received audio data.');
        _data.addAll(v);
        channel?.sink.add(v);
      });

      await _recorder.startRecorder(
        toStream: streamController.sink,
        codec: Codec.pcm16,
        numChannels: 1,
        bufferSize: 0,
        sampleRate: 16000, //tSAMPLERATE,
      );

      _recorder.onProgress!.listen((e) {
        // var date = DateTime.fromMillisecondsSinceEpoch(
        //     e.duration.inMilliseconds,
        //     isUtc: true);
        // var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
        dbLevel.value = e.decibels;
      });
    } on Exception catch (err) {
      _recorder.logger.e('startRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = _isLongPressed ? Colors.grey : Colors.white;

    return Stack(
      children: [
        // 你的主要内容，这里是一个可点击的按钮
        Positioned(
          key: _overlayKey,
          child: GestureDetector(
            onLongPressStart: (_) async {
              await _onLongPress();
              print(
                  (_overlayKey.currentContext?.findRenderObject() as RenderBox)
                      .localToGlobal(Offset.zero));
              setState(() {
                _isLongPressed = true;
                numberKeypan(context: context);
              });
              widget.onTap(_isLongPressed); // 开始动画
            },
            onLongPressMoveUpdate: (details) {
              if (details.localPosition.dy > 60 ||
                  details.localPosition.dx > 40) {
                _isCancel = true;
              } else {
                _isCancel = false;
              }
            },
            onLongPressEnd: (_) async {
              await _onLongPressEnd(_);
              setState(() {
                _isLongPressed = false;
                overlayEntry?.remove();
                overlayEntry = null;
              });
              widget.onTap(_isLongPressed);
            },
            child: AnimatedContainer(
              curve: const Cubic(0.160, 0.265, 0.125, 0.995),
              duration: const Duration(milliseconds: 500),
              child: Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mic, color: Color(0xFF6D7380)),
                    ],
                  )),
            ),
          ),
        ),
      ],
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
  late bool _isCounting;
  late bool _isSpeeching;
  late FlutterTts _flutterTts;
  late bool _enableSpeech;

  Future _speak(String text) async {
    if (_enableSpeech) {
      await _flutterTts.speak(text);
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    _isCounting = false;
    _isSpeeching = false;
    _enableSpeech = false;
    _flutterTts = FlutterTts();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _flutterTts.awaitSpeakCompletion(true);
      await _flutterTts.setLanguage(
        "zh-CN",
      );

      await _flutterTts.setSpeechRate(1.0);

      await _flutterTts.setVolume(1.0);

      await _flutterTts.setPitch(1.0);
    });
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

  String _calculateResult() {
    try {
      setState(() {
        _isCounting = false;
      });
      // 使用 expressions 包来解析和计算表达式
      final expression = Expression.parse(_input);
      var evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      _result = result.toString();
    } catch (e) {
      _result = '错误';
    }
    _textEditingController.text = _result;
    _input = _result;
    return _result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ink(
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
                          hintText: '请输入内容',
                        ),
                        focusNode: _focusNode,
                        enableSuggestions: false,
                        showCursor: true,
                        readOnly: false,
                        onTap: () {},
                        onTapOutside: (event) {
                          print('1213');
                        },
                        onEditingComplete: () {
                          print('1213');
                        },
                        onSubmitted: (value) {
                          print('1213');
                        },
                        onAppPrivateCommand: (action, data) {
                          print('1213');
                        },
                        onChanged: (value) {
                          _input = value;
                        },
                      ),
                    ),
                  ),
                  LongPressColorChangeWidget(
                    onTap: (isSpeeching) {
                      setState(() {
                        _isSpeeching = isSpeeching;
                      });
                    },
                    onCommit: (text) {
                      setState(() {
                        _textEditingController.text = text;
                        _input = text;
                      });
                    },
                  ),
                  Container(
                    color: Colors.grey,
                    width: 1,
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_focusNode);
                    },
                    borderRadius: BorderRadius.circular(40),
                    splashColor: Colors.grey,
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
            height: MediaQuery.of(context).viewInsets.bottom > 0
                ? 0
                : _focusNode.hasFocus
                    ? null
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
                          width: 55,
                          height: 50,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                _enableSpeech = !_enableSpeech;
                              });
                              widget.onDel?.call();
                            },
                            color: _enableSpeech
                                ? Colors.white
                                : Colors.grey.withAlpha(0),
                            elevation: 2,
                            splashColor: Colors.grey,
                            padding: const EdgeInsets.all(0),
                            child: Icon(_enableSpeech
                                ? CupertinoIcons.speaker_slash
                                : CupertinoIcons.speaker_2),
                          ),
                        ),
                        Container(
                          width: 55,
                          height: 50 * 1.6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            onPressed: () {
                              // disKeypan();
                              widget.onCommit?.call();
                            },
                            elevation: 0,
                            child: const Text(
                              '下一项',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                          width: 55,
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            onPressed: () {
                              // disKeypan();
                              widget.onCommit?.call();
                            },
                            color: Colors.blue,
                            elevation: 0,
                            padding: const EdgeInsets.all(0),
                            child: const Text(
                              "再 记",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                      ],
                    ),
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: List.generate(list.length, (index) {
                          return Ink(
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.grey,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.25),
                                ),
                                alignment: Alignment.center,
                                height: 50,
                                width: (MediaQuery.of(context).size.width -
                                        55 -
                                        95.w) /
                                    3,
                                child: Text(
                                  list[index],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onTap: () async {
                                if (list[index] != "C") {
                                  if (list[index] == ".") {
                                    _speak('点');
                                  } else {
                                    _speak(list[index]);
                                  }

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
                      width: 95.w,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 60.h,
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              onPressed: () {
                                if (_input.isNotEmpty) {
                                  setState(() {
                                    _input =
                                        _input.substring(0, _input.length - 1);
                                    _textEditingController.text = _input;
                                  });
                                }
                              },
                              color: _isSpeeching ? Colors.red : Colors.white,
                              child: _isSpeeching
                                  ? Text(
                                      '滑到此处取消',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                    )
                                  : Icon(
                                      CupertinoIcons.delete_left,
                                      size: 35.sp,
                                    ),
                            ),
                          ),
                          Ink(
                            color: Colors.white,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              runSpacing: 15.h,
                              children: [
                                SizedBox(
                                    width: 35.sp, // 宽度和高度相同以实现圆形
                                    height: 35.sp,
                                    child: MaterialButton(
                                      shape: const CircleBorder(),
                                      elevation: 2,
                                      color: Colors.white,
                                      padding: EdgeInsets.zero,
                                      splashColor: Colors.grey,
                                      onPressed: () async {
                                        _speak('加');
                                        _isCounting = true;
                                        _onButtonPressed('+');
                                      },
                                      child: Icon(
                                        CupertinoIcons.add,
                                        size: 30.sp,
                                      ),
                                    )),
                                SizedBox(
                                    width: 35.sp, // 宽度和高度相同以实现圆形
                                    height: 35.sp,
                                    child: MaterialButton(
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.zero,
                                      splashColor: Colors.grey,
                                      elevation: 2,
                                      color: Colors.white,
                                      onPressed: () async {
                                        _speak('减');
                                        _isCounting = true;
                                        _onButtonPressed('-');
                                      },
                                      child: Icon(
                                        CupertinoIcons.minus,
                                        size: 30.sp,
                                      ),
                                    )),
                                SizedBox(
                                    width: 35.sp, // 宽度和高度相同以实现圆形
                                    height: 35.sp,
                                    child: MaterialButton(
                                      shape: const CircleBorder(),
                                      elevation: 2,
                                      color: Colors.white,
                                      padding: EdgeInsets.zero,
                                      splashColor: Colors.grey,
                                      onPressed: () async {
                                        _speak('乘');
                                        _isCounting = true;
                                        _onButtonPressed('*');
                                      },
                                      child: Icon(
                                        CupertinoIcons.multiply,
                                        size: 30.sp,
                                      ),
                                    )),
                                SizedBox(
                                    width: 35.sp, // 宽度和高度相同以实现圆形
                                    height: 35.sp,
                                    child: MaterialButton(
                                      shape: const CircleBorder(),
                                      elevation: 2,
                                      color: Colors.white,
                                      padding: EdgeInsets.zero,
                                      splashColor: Colors.grey,
                                      onPressed: () async {
                                        _speak('除');
                                        _isCounting = true;
                                        _onButtonPressed('/');
                                      },
                                      child: Icon(
                                        CupertinoIcons.divide,
                                        size: 30.sp,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                              child: MaterialButton(
                            onPressed: () async {
                              if (_isCounting) {
                                var result = _calculateResult();
                                _speak('等于$result');
                              }

                              widget.onCommit?.call();
                            },
                            splashColor: Colors.grey,
                            color: Colors.blue,
                            child: !_isCounting
                                ? const Text(
                                    "确 认",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Icon(
                                    CupertinoIcons.equal,
                                    color: Colors.white,
                                    size: 35.sp,
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

class RecodingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecodingButtonState();
  final bool isEnabled;

  const RecodingButton({super.key, required this.isEnabled});
}

class _RecodingButtonState extends State<RecodingButton> {
  late List<double> _sounds;
  late int num;

  @override
  void initState() {
    super.initState();
    num = 10;
    _sounds = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: 30.h,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ValueListenableBuilder<double?>(
                valueListenable: dbLevel,
                builder: (context, value, builder) {
                  if (_sounds.length > num) {
                    _sounds.removeAt(0);
                  }
                  _sounds.add(value!);
                  return CustomPaint(
                    painter: CustomSoundSizeAnim(widget.isEnabled,
                        soundList: _sounds),
                  );
                })),
      ],
    );
  }
}

class CustomSoundSizeAnim extends CustomPainter {
  List<double> soundList;
  CustomSoundSizeAnim(this.isEnabled, {required this.soundList});
  Paint? _paint;
  final bool isEnabled;
  @override
  void paint(Canvas canvas, Size size) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 0.5;
    drawRect(canvas, size);
  }

  drawRect(Canvas canvas, Size size) {
    double count = 10;
    soundList = [...soundList.reversed];
    for (int i = 0; i < count / 2; i++) {
      _paint?.color = _paint!.color.withAlpha(255 - i * 5);
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(
                  center: Offset(size.width / 2 + i * 8, size.height / 2),
                  width: 1,
                  height: 4),
              4,
              8),
          _paint!);
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(
                  center: Offset(size.width / 2 - i * 8, size.height / 2),
                  width: 1,
                  height: 4),
              4,
              8),
          _paint!);
    }
    _paint?.color = _paint!.color.withAlpha(255);
    for (int i = 0; i < soundList.length / 2; i++) {
      _paint?.color = _paint!.color.withAlpha(255 - i * 5);
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(
                  center: Offset(size.width / 2 + i * 8, size.height / 2),
                  width: 4,
                  height: soundList[i] / 3),
              8,
              8),
          _paint!);
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(
                  center: Offset(size.width / 2 - i * 8, size.height / 2),
                  width: 4,
                  height: soundList[i] / 3),
              8,
              8),
          _paint!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
