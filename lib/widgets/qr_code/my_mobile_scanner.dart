import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/nav/args.dart';
import 'package:lime/nav/routes.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

class MyMobileScanner extends StatefulWidget {
  const MyMobileScanner({super.key, this.args});

  final MyMobileScannerArgs? args;

  factory MyMobileScanner.route(BuildContext context) =>
      MyMobileScanner(args: context.args<MyMobileScannerArgs?>());

  @override
  State<MyMobileScanner> createState() => _MyMobileScannerState();
}

class _MyMobileScannerState extends State<MyMobileScanner>
    with WidgetsBindingObserver {
  final controller =
      MobileScannerController(formats: const [BarcodeFormat.qrCode]);
  StreamSubscription<Object?>? _subscription;
  Barcode? result;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      // case AppLifecycleState.detached:
      // case AppLifecycleState.hidden:
      // case AppLifecycleState.paused:
      //   return;
      // case AppLifecycleState.resumed:
      //   if (_subscription != null) {
      //     return;
      //   }
      //   _subscription = controller.barcodes.listen(_handleBarcode);
      //   _requestCamera();
      //   controller.start();
      // case AppLifecycleState.inactive:
      //   _subscription?.cancel();
      //   _subscription = null;
      //   controller.stop();
    }
  }

  Future<void> _requestCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      return;
    }
    // if (mounted) {
    //   Navigator.of(context).pop();
    // }

    // var status = await Permission.camera.status;

    // if (status.isGranted) {
    //   return;
    // }

    // if (status.isPermanentlyDenied || (Platform.isAndroid && status.isDenied)) {
    //   if (mounted) {
    //     final result = await showOkCancelAlertDialog(
    //         context: context,
    //         title: '相机权限',
    //         message: "未开启相机权限，如需使用请在系统设置进行开启，是否前往系统设置？");
    //     if (result == OkCancelResult.ok) {
    //       await openAppSettings();
    //     }
    //     if (mounted) {
    //       Navigator.of(context).pop();
    //     }
    //     return;
    //   }
    // }
  }

  @override
  void initState() {
    super.initState();
    _requestCamera();
    WidgetsBinding.instance.addObserver(this);
    _subscription = controller.barcodes.listen(_handleBarcode);
    controller.start();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    _subscription = null;
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 0.5.sw,
      height: 0.5.sw,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: MobileScanner(
              fit: BoxFit.contain,
              controller: controller,
              scanWindow: scanWindow,
              errorBuilder: (ctx, error, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      error.errorText,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextButton(
                      onPressed: openAppSettings,
                      child: Text('前往设置'),
                    ),
                    TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('返回'),
                    ),
                  ],
                );
              },
            ),
          ),
          // ValueListenableBuilder(
          //   valueListenable: controller,
          //   builder: (context, value, child) {
          //     if (!value.isInitialized ||
          //         !value.isRunning ||
          //         value.error != null) {
          //       return const SizedBox.shrink();
          //     }
          //     return CustomPaint(
          //       painter: _ScannerOverlay(
          //         scanWindow: scanWindow,
          //         borderRadius: 12.r,
          //       ),
          //     );
          //   },
          // )
        ],
      ),
    );
  }

  Future<void> _handleBarcode(BarcodeCapture event) async {
    if (result != null) {
      return;
    }

    setState(() {
      result = event.barcodes.firstOrNull;
    });

    if (result?.displayValue != null) {
      unawaited(_hapticFeedback());
      await controller.stop();

      if (widget.args != null) {
        widget.args?.onScanned?.call(result?.displayValue ?? '');
        if (widget.args?.onScannedAsync != null) {
          await widget.args!.onScannedAsync!.call(result?.displayValue ?? '');
        }
      }

      if (mounted) {
        Navigator.of(context).pop(result?.displayValue);
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
}

class _ScannerOverlay extends CustomPainter {
  const _ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOver;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // First, draw the background,
    // with a cutout area that is a bit larger than the scan window.
    // Finally, draw the scan window itself.
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(_ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}

extension MobileScannerExceptionExtensions on MobileScannerException {
  String get errorText {
    switch (errorCode) {
      case MobileScannerErrorCode.controllerAlreadyInitialized:
        return '相机已经初始化，操作重复';
      case MobileScannerErrorCode.controllerDisposed:
        return '相机已被销毁，无法使用';
      case MobileScannerErrorCode.controllerUninitialized:
        return '相机还未初始化，无法使用';
      case MobileScannerErrorCode.genericError:
        return '未知错误';
      case MobileScannerErrorCode.permissionDenied:
        return '用户尚未授权使用相机';
      case MobileScannerErrorCode.unsupported:
        return '不支持使用相机';
    }
  }
}
