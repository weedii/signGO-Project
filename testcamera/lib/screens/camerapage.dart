import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'dart:typed_data';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  @override
  void initState() {
    super.initState();
    startCamera(1);
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.low,
      enableAudio: false,
    );
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {}); // To refresh widget
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });

    cameraController.startImageStream((CameraImage image) {
      analyzeFrame(image);
    });
  }

  final logger = Logger();

  Future<void> analyzeFrame(CameraImage image) async {
    try {
      final Uint8List bytes = _concatenatePlanes(image.planes);

      var response = await http.post(
        Uri.parse('http://192.168.223.33:5001/upload'),
        body: base64.encode(bytes),
        headers: {'Content-Type': 'application/octet-stream'},
      );

      // Handle the API response
      print('API Response: ${response.body}');
      print('API Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var predictedClass = jsonResponse['predicted_class'];

        // TODO: Handle the predicted class
        logger.d('Predicted class: $predictedClass');
      } else {
        // Handle API error
        logger.e('API request failed with status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      logger.e('Error during API request', e, stackTrace);
    }
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    int totalSize = 0;
    for (Plane plane in planes) {
      totalSize += plane.bytes.length;
    }

    Uint8List concatenatedBytes = Uint8List(totalSize);
    int concatenatedIndex = 0;

    for (Plane plane in planes) {
      concatenatedBytes.setRange(concatenatedIndex,
          concatenatedIndex + plane.bytes.length, plane.bytes);
      concatenatedIndex += plane.bytes.length;
    }

    return concatenatedBytes;
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 55),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'signGO',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.purple,
                ],
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(6.0),
            child: Opacity(
              opacity: 1,
              child: Container(
                height: 1.4,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  startCamera(direction);
                });
              },
              child: button(
                  Icons.flip_camera_ios_outlined, Alignment.bottomCenter),
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

Widget button(IconData icon, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Container(
      margin: const EdgeInsets.only(
        left: 0,
        bottom: 45,
      ),
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ]),
      child: Center(
        child: Icon(
          icon,
          color: Colors.black54,
        ),
      ),
    ),
  );
}
