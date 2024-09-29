// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
//import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lime/pages/individual.dart';
//import 'package:lime/pages/qipao.dart';
import 'package:lime/pages/tabs.dart';
//import 'package:lime/pages/test2.dart';
//import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:vibration/vibration.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VoiceCommandButton extends StatefulWidget {
  const VoiceCommandButton({super.key});
  @override
  State<StatefulWidget> createState() => _VoiceCommandButtonState();
}

class _VoiceCommandButtonState extends State<VoiceCommandButton> {
  OverlayEntry? _response;
  String _questionText = '';

  @override
  Widget build(BuildContext context) {
    return VoiceMessageWidget(
      onRecordCancel: () {
        unawaited(Fluttertoast.showToast(msg: '取消语音请求'));
      },
      onRecordCompleted: (data) async {
        try {
          // if (data == null) {
          //   return;
          // }
          _questionText = data;
          _response?.remove();
          _response?.dispose();
          _response = null;
          unawaited(_showResponse());
        } catch (e) {
          unawaited(Fluttertoast.showToast(msg: e.toString()));
        }
      },
      onRecordStart: () {
        // _response?.remove();
        // _response?.dispose();
        // _response = null;
      },
    );
  }

  Future<void> _showResponse() async {
    _response = OverlayEntry(builder: (context) {
      return Positioned(
        top: 0.1.sh,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            width: 1.sw,
            height: 0.7.sh,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(1, 1), //阴影xy轴偏移量
                          blurRadius: 2, //阴影模糊程度
                          spreadRadius: 3 //阴影扩散程度
                          )
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withAlpha(100),
                        HexColor('#54C395').withAlpha(100),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BubbleBox(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                            shape: BubbleShapeBorder(
                              direction: BubbleDirection.right,
                              position: const BubblePosition.center(0),
                              arrowQuadraticBezierLength: 1,
                            ),
                            margin: const EdgeInsets.all(4),
                            backgroundColor: HexColor('#54C395'),
                            child: Text(
                              _questionText,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BubbleBox(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                            shape: BubbleShapeBorder(
                              direction: BubbleDirection.left,
                              position: const BubblePosition.center(0),
                              arrowQuadraticBezierLength: 1,
                            ),
                            margin: const EdgeInsets.all(4),
                            backgroundColor: const Color(0xffE7E7ED),
                            child: Text(
                              _questionText,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: ClipOval(
                    child: InkWell(
                      onTap: () {
                        _response?.remove();
                        _response?.dispose();
                        _response = null;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary),
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });

    Overlay.of(context).insert(_response!);
  }

  @override
  void dispose() {
    _response?.remove();
    _response?.dispose();
    _response = null;
    super.dispose();
  }
}

Codec _codec = Codec.pcm16;

class VoiceMessageWidget extends StatefulWidget {
  const VoiceMessageWidget({
    super.key,
    this.onRecordCompleted,
    this.onRecordStart,
    this.onRecordCancel,
  });

  final void Function(String)? onRecordCompleted;
  final VoidCallback? onRecordStart;
  final VoidCallback? onRecordCancel;

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  OverlayEntry? entry;
  final _voiceController = ValueNotifier(true);
  final _recorder = FlutterSoundRecorder();
  StreamSubscription<Uint8List>? _dataSubscription;
  final _data = <int>[];
  late bool isSound;
  final _textController = ValueNotifier('');

  @override
  void initState() {
    _initRecorder();
    super.initState();
    isSound = false;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async => _onLongPress(),
      onLongPressEnd: (details) async => _onLongPressEnd(details),
      onLongPressMoveUpdate: _onLongPressMoveUpdate,
      child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    offset: const Offset(1, 1.0), //阴影xy轴偏移量
                    blurRadius: 2, //阴影模糊程度
                    spreadRadius: 0.5 //阴影扩散程度
                    )
              ],
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(color: Colors.grey.withAlpha(122))),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                      textAlign: isSound ? TextAlign.center : TextAlign.start,
                      enabled: !isSound,
                      decoration: InputDecoration(
                        hintText: isSound ? '按 住 说 话' : '有什么问题尽管问我~',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: isSound ? Colors.black : Colors.grey),
                        icon: const Icon(Icons.control_point),
                      ))),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isSound = !isSound;
                    });
                  },
                  child: isSound
                      ? const Icon(
                          Icons.contactless_outlined,
                        )
                      : const Icon(Icons.keyboard_alt_outlined)),
            ],
          )),
    );
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
      entry?.remove();
      await _recorder.stopRecorder();
      if (_dataSubscription != null) {
        await _dataSubscription!.cancel();
        _dataSubscription = null;
      }
      if (_voiceController.value) {
        // print('audio data: ${result.toString()}');
        widget.onRecordCompleted?.call(_textController.value);
      } else {
        widget.onRecordCancel?.call();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
      entry = OverlayEntry(
        builder: (context) =>
            _OverlayVoiceRecorder(_voiceController, _textController),
      );
      _voiceController.value = true;
      text = '';
      _textController.value = '';
      widget.onRecordStart?.call();
      Overlay.of(context).insert(entry!);
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
    channel = IOWebSocketChannel.connect('ws://17.tcp.cpolar.top:12560');
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

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    if (_voiceController.value && details.globalPosition.dy < 0.84.sh) {
      unawaited(_hapticFeedback());
      _voiceController.value = false;
    }
    if (!_voiceController.value && details.globalPosition.dy >= 0.84.sh) {
      unawaited(_hapticFeedback());
      _voiceController.value = true;
    }
  }

  Future<void> _hapticFeedback() async {
    if (Platform.isAndroid && await Vibration.hasVibrator() == true) {
      await Vibration.vibrate(duration: 15);
    } else if (Platform.isIOS) {
      await HapticFeedback.selectionClick();
    }
  }

  @override
  void dispose() {
    _voiceController.dispose();
    _recorder.stopRecorder();
    _recorder.closeRecorder();
    super.dispose();
  }
}

class _OverlayVoiceRecorder extends StatefulWidget {
  const _OverlayVoiceRecorder(this._isTouchingBottom, this._textController);
  final ValueListenable<bool> _isTouchingBottom;
  final ValueListenable<String> _textController;

  @override
  State<_OverlayVoiceRecorder> createState() => __OverlayVoiceRecorderState();
}

class __OverlayVoiceRecorderState extends State<_OverlayVoiceRecorder> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget._isTouchingBottom,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Theme.of(context).colorScheme.surface
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0.68.sh,
                left: 0.5.sw,
                child: _BottomView(value, widget._textController),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomView extends StatelessWidget {
  const _BottomView(this._isEnabled, this._textController);
  final bool _isEnabled;
  final ValueListenable<String> _textController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FractionalTranslation(
        translation: const Offset(-0.5, 0),
        child: ClipOval(
          child: ShaderMask(
            shaderCallback: (r) {
              return LinearGradient(
                colors: !_isEnabled
                    ? [Colors.grey.withAlpha(100), Colors.grey.withAlpha(100)]
                    : [Colors.white, Colors.white],
              ).createShader(r);
            },
            blendMode: BlendMode.darken,
            child: Container(
              padding: EdgeInsets.only(
                  bottom:
                      (barKey.currentContext?.findRenderObject() as RenderBox)
                          .size
                          .height,
                  top: 0.03.sh),
              alignment: Alignment.topCenter,
              width: 2.2.sw,
              height: 1.sh,
              decoration: BoxDecoration(color: HexColor('#54C395')),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      width: 0.7.sw,
                      height: 0.1.sh,
                      child: ValueListenableBuilder<String>(
                          valueListenable: _textController,
                          builder: (context, value, child) {
                            return Text(
                              value.isEmpty ? '我在听' : value,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    bottom: 0.68.sh,
                    child: RecodingButton(
                      isEnabled: _isEnabled,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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
    num = (0.6.sw / 8).toInt();
    _sounds = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.isEnabled ? '松开发送,上滑取消' : '松开，取消发送',
          style: TextStyle(
              color: widget.isEnabled
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Colors.red),
        ),
        Container(
            height: 50.h,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: 1.sw - 40,
            decoration: BoxDecoration(
                color: widget.isEnabled ? Colors.white : Colors.red,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(color: Colors.grey.withAlpha(122))),
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
    _paint = Paint()..color = isEnabled ? Colors.orange : Colors.white;
    drawRect(canvas, size);
  }

  drawRect(Canvas canvas, Size size) {
    double count = (0.6.sw / 8);
    soundList = [...soundList.reversed];
    for (int i = 0; i < count / 2; i++) {
      _paint?.color = _paint!.color.withAlpha(255 - i * 5);
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(
                  center: Offset(size.width / 2 + i * 8, size.height / 2),
                  width: 4,
                  height: 4),
              8,
              8),
          _paint!);
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(
                  center: Offset(size.width / 2 - i * 8, size.height / 2),
                  width: 4,
                  height: 4),
              8,
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
