import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/nav/routes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

class QrView extends StatefulHookConsumerWidget {
  const QrView({Key? key, this.scanTheCode}) : super(key: key);

  /// 从指定的[BuildContext]加载路由参数并初始化页面。
  factory QrView.route(BuildContext context) =>
      QrView(scanTheCode: context.args<Future<void> Function(Barcode)?>());

  final Future<void> Function(Barcode)? scanTheCode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrViewState();
}

class _QrViewState extends ConsumerState<QrView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildQrView(context),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400.w ||
            MediaQuery.of(context).size.height < 400.w)
        ? 200.0.w
        : 300.0.w;

    return QRView(
      key: qrKey,
      onQRViewCreated: (c) => _onQRViewCreated(context, c),
      overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.primary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    final nav = Navigator.of(context);
    if (Platform.isAndroid) {
      controller.resumeCamera();
    }
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((event) async {
      setState(() {
        result = event;
      });
      if (result?.code != null) {
        await _hapticFeedback();
        await controller.pauseCamera();
        if (widget.scanTheCode != null) {
          await widget.scanTheCode!(result!);
        }
        nav.pop(result?.code);
      }
    });
  }

  Future<void> _hapticFeedback() async {
    if (Platform.isAndroid && await Vibration.hasVibrator() == true) {
      await Vibration.vibrate(duration: 15);
    } else if (Platform.isIOS) {
      await HapticFeedback.selectionClick();
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // Log.e('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
