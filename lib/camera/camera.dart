import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thu_phi/check_in4/check_in4.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as di;
import 'dart:io';


class camera extends StatefulWidget {
  const camera({Key? key}) : super(key: key);

  @override
  State<camera> createState() => _cameraState();
}

class _cameraState extends State<camera> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  di.File? _image;
  String? result;


  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async {
    cameras = await availableCameras();
    cameraController =
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: true);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        backgroundColor: Color(0xD9E5E0E0),
        body: Stack(
          children: [
            Container(
              width: 400,
              padding: EdgeInsets.only(bottom: 95),
              child: CameraPreview(cameraController),
            ),
            GestureDetector(
              onTap: () async {
                cameraController.takePicture().then((XFile? file) async {
                  if (mounted) {
                    if (file != null) {
                      print("thanh cong");
                      _image = File(file.path);
                      upImage();
                      Get.to(Check_in4(
                        imagePath: file,
                        imageName: file.name,
                        idCarHint: result!,
                      ));
                    }
                  }
                });
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 10,
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  upImage() async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.31.76:4000/"));
    var pic = http.MultipartFile.fromBytes(
        'file', _image!.readAsBytesSync().buffer.asInt8List(),
        filename: "image_recognized.jpg");
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    result = String.fromCharCodes(responseData);
    print(result);
  }
}
