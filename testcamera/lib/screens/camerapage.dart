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
  bool _isRecording = false; // Flag to track recording status

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

    setState(() {
      _isRecording = true; // Update the recording status
    });

    // Start recording
    await _controller.startVideoRecording();

    setState(() {});

    // Start sending videos every 2 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
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
    final url = Uri.parse('http://172.22.101.51:5001/upload');
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

      // ZA BODY
      body: Stack(
        children: [
          Container(
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
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the camera preview if the camera is initialized
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(
                      50.0), // Adjust the radius value as needed
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      50.0), // Same radius value as the container
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: 16 / 23,
                          child: CameraPreview(_controller),
                        )
                      : const Center(
                          child: Text("No cameras available"),
                        ),
                ),
              ),

              Column(
                children: [
                  // Button to start recording
                  if (!_isRecording)
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: startRecording,
                      child: const Text(
                        'Start..',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      apiResponse,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
