import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';

import '../../../core/routes/router_names.dart';

class ProfilePhotoCameraScreen extends StatefulWidget {
  const ProfilePhotoCameraScreen({
    super.key,
  });
  @override
  _ProfilePhotoCameraScreenState createState() =>
      _ProfilePhotoCameraScreenState();
}

class _ProfilePhotoCameraScreenState extends State<ProfilePhotoCameraScreen> {
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

  Dio dio = Dio();
  String fileUploadUrl = 'https://api.achievify.net/upload/files';

  bool _isLoading = false;

  setLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  // ignore: unused_field
  dynamic _uploadedUrl;

  Future<void> uploadFile(File file) async {
    try {
      setLoading();
      String fileName = basename(file.path);
      var data = FormData.fromMap({
        'files': [await MultipartFile.fromFile(file.path, filename: fileName)],
      });

      var dio = Dio();
      var response = await dio.request(
        fileUploadUrl,
        options: Options(method: 'POST', contentType: 'multipart/form-data'),
        data: data,
      );

      setLoading();

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.data);
        _uploadedUrl = data['data']['upload_result']['Location'];
        // Handle the success response
        print("File uploaded successfully: ${response.data}");
      } else {
        // Handle the error
        print("Failed to upload file: ${response.statusMessage}");
      }
    } catch (e) {
      print("Error occurred during file upload: $e");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: InkWell(
            onTap: () => context.nav.pop(),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
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
                        width: 300,
                        // padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(color: AppColors.grey)),
                        child: CameraPreview(_controller!),
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: Image.file(File(_imageFile!.path))),
          const SizedBox(height: 20),
          const Text(
            'Review your photo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.white),
          ),
          Gap(5),
          const Text(
            'Make sure it’s well-lit, clear, and matches the person in the ID.',
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
                  onTap: () async {
                    File file = File(_imageFile!.path);
                    await uploadFile(file);
                    setState(() {
                      _isLoading = false;
                    });

                    context.auth.register().then((success) {
                      if (success) {
                        context.nav.pushNamed(Routes.regsitrationConfirmScreen);
                      }
                    });
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
