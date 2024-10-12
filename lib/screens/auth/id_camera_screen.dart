import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salama_users/constants/colors.dart';
import 'package:salama_users/screens/auth/profile_photo_consent_screen.dart';
import 'package:salama_users/widgets/busy_button.dart';

class CameraScreen extends StatefulWidget {
  final Map<String, dynamic> payload;
  const CameraScreen({super.key, required this.payload});
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      _initializeControllerFuture = _controller!.initialize();
      setState(
          () {}); // Ensure the UI updates after initializing the controller
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      setState(() {
        _imageFile = image;
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _submitPhoto() async {
    // Submit the photo logic
    if (_imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = join(directory.path, '${DateTime.now()}.png');
      await _imageFile!.saveTo(filePath);
      print('Photo saved to $filePath');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          title: const Text('')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(20),
          _imageFile == null
              ? FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: CameraPreview(_controller!),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error initializing camera'),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.file(File(_imageFile!.path))),
          const SizedBox(height: 20),
          const Text(
            'Is the front of your ID clear?\nMake sure it’s well-lit, clear, and nothing is cut off.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.white),
          ),
          const SizedBox(height: 20),
          const Spacer(),
          if (_imageFile == null)
            ElevatedButton(
              onPressed: _takePicture,
              child: const Text('Take a picture'),
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BusyButton(
                  title: "Submit Photo",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePhotoConsentScreen(
                            payload: widget.payload)));
                  },
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _imageFile = null;
                    });
                  },
                  child: const Text('Retake photo'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
