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
   late CameraController _controller ;
  Timer? _timer;
  bool _isRecordingInProgress = false; // Track if recording
  TextEditingController controller = TextEditingController();


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
      _isRecordingInProgress = true;
    });

    // Start recording
    await _controller.startVideoRecording();

    setState(() {});

    // Send short videos every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      recordAndSendVideo();
    });
  }

  Future<void> stopRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }

    // Stop recording
    await _controller.stopVideoRecording();

    setState(() {
      _isRecordingInProgress = false;
      apiResponse = "";
    });
  }

  String apiResponse = '';

  Future<void> recordAndSendVideo() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }


    final XFile videoFile = await _controller.stopVideoRecording();

    // Send every video to the API
    final url = Uri.parse('http://172.22.101.51:5001/upload');
    final request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('video', videoFile.path));
    final response = await request.send();

    // Print the API response here to check
    print('API Status Code: ${response.statusCode}');

    final responseString = await response.stream.bytesToString();
    setState(() {
      apiResponse =
          responseString;
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
        backgroundColor: Color.fromARGB(255, 18, 91, 116),
      ),
      //
      // ZA BODY
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 18, 91, 116),
          ),
          Column(
            children: [
              Container(
                child: ClipRRect(
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
              SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  // Button to start and stop recording
                  if (_isRecordingInProgress)
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                50.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 11, 122, 159),
                        ),
                      ),
                      onPressed: stopRecording,
                      child: const Text(
                        '                                    Stop                                    ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  if (!_isRecordingInProgress)
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                50.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 11, 122, 159),
                        ),
                      ),
                      onPressed: startRecording,
                      child: const Text(
                        '                                    Start                                    ',
                        style: TextStyle(color: Colors.white),
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
