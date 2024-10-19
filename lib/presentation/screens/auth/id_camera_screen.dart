import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/core/routes/router_names.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';

class CameraScreen extends StatefulWidget {
  final String documentType;
  const CameraScreen({super.key, required this.documentType});
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

  Dio dio = Dio();
  String fileUploadUrl = 'https://api.achievify.net/upload/files';

  bool _isLoading = false;

  setLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

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

      // if (response.statusCode == 200) {
      //   print(json.encode(response.data));
      // }
      // else {
      //   print(response.statusMessage);
      // }
      // FormData formData = FormData.fromMap({
      //   "files": await MultipartFile.fromFile(file.path, filename: fileName),
      // });
      //
      // // Make the POST request
      // Response response = await dio.post(
      //   fileUploadUrl,
      //   data: formData,
      //   options: Options(
      //     headers: {
      //       "Content-Type": "multipart/form-data",
      //     },
      //   ),
      // );

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
                  isLoading: _isLoading,
                  onTap: () async {
                    File file = File(_imageFile!.path);
                    await uploadFile(file);
                    setState(() {
                      _isLoading = false;
                    });
                    context.auth.onboardingData.value['internationalPassport'] =
                        _uploadedUrl ?? "";
                    context.auth.onboardingData.value['drivingLicense'] =
                        _uploadedUrl ?? "";
                    context.auth.onboardingData.value['votersCard'] =
                        _uploadedUrl ?? "";
                    context.auth.onboardingData.value['nin'] =
                        _uploadedUrl ?? "";

                    context.nav.pushNamed(Routes.profilePhotoConsentScreen);
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
