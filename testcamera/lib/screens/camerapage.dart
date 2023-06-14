// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class VideoRecordingPage extends StatefulWidget {
  @override
  _VideoRecordingPageState createState() => _VideoRecordingPageState();
}

class _VideoRecordingPageState extends State<VideoRecordingPage> {
  late CameraController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Initialize the camera
    WidgetsFlutterBinding.ensureInitialized();
    availableCameras().then((cameras) {
      _controller = CameraController(cameras[1], ResolutionPreset.low);
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  Future<void> startRecording() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    // Start recording
    await _controller.startVideoRecording();

    setState(() {});

    // Start sending videos every 2 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      recordAndSendVideo();
    });
  }

  String apiResponse = ''; // Variable to store the API response

  Future<void> recordAndSendVideo() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }

    // Stop recording
    final XFile videoFile = await _controller.stopVideoRecording();

    // Send video to the API
    final url = Uri.parse('http://192.168.223.33:5001/upload');
    final request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('video', videoFile.path));
    final response = await request.send();

    // Handle the API response here
    print('API Status Code: ${response.statusCode}');

    final responseString = await response.stream.bytesToString();
    setState(() {
      apiResponse =
          responseString; // Update the apiResponse variable with the API response
    });

    // Continue recording
    await _controller.startVideoRecording();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Recording'),
      ),
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the camera preview if the camera is initialized
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: 16 / 23,
                    child: CameraPreview(_controller),
                  )
                : const Center(
                    child: Text("No cameras available"),
                  ),

            // Button to start recording
            ElevatedButton(
              onPressed: startRecording,
              child: const Text('Start..'),
            ),
            Text(apiResponse),
          ],
        ),
      ),
    );
  }
}
