import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _urlController =
      TextEditingController(text: 'http://192.168.1.7:5000/upload');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: '服务器URL',
              ),
            ),
            TextButton(
              onPressed: _sendImage,
              child: Text('发送图片'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendImage() async {
    final file = await _selectImage();
    final stream = await file!.openRead().toList();
    if (file != null) {
      // 将图片转换为MultipartFile
      final http.MultipartFile multipartFile =
          await http.MultipartFile.fromBytes(
        'file',
        stream.cast<int>(),
        filename: file.name, // 根据实际情况调整MIME类型
      );

      // 构造请求体
      final FormData formData = FormData.fromMap({
        "file": multipartFile,
      });
      var request =
          http.MultipartRequest('POST', Uri.parse(_urlController.text));
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        //final outputPath = await _saveExcelFile(response);
        print('Excel文件已保存至：');
      } else {
        print(response);
      }
    }
  }

  Future<XFile?> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile;
    }
    return null;
  }

  Future<String> _saveExcelFile(http.Response response) async {
    final outputFolder = 'output_1';
    if (!await Directory(outputFolder).exists()) {
      await Directory(outputFolder).create();
    }
    final excelFilename = response.headers['content-disposition']
        ?.split('filename=')[1]
        .trim()
        .replaceAll('"', '');
    final outputPath = '$outputFolder/$excelFilename';
    final file = File(outputPath);
    await file.writeAsBytes(response.bodyBytes);
    return outputPath;
  }
}
