import 'package:flutter/material.dart';
import 'package:salama_users/screens/auth/id_camera_screen.dart';

class IdPhotoPage extends StatelessWidget {
  final Map<String, dynamic> payload;
  const IdPhotoPage({super.key, required this.payload});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Photo of your ID",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Choose which type of document you’re going to use.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                "Use a document that is in date or has expired in the last three months. If you choose a residency permit it must not have expired.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              _buildListTile(
                title: 'International Passport',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraScreen(
                            payload: payload,
                        documentType: "internationalPassport",
                          )));
                  // Handle tap
                },
              ),
              _buildListTile(
                title: 'Driving Licence',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraScreen(
                            payload: payload,
                        documentType: "drivingLicense",
                          )));
                  // Handle tap
                },
              ),
              _buildListTile(
                title: 'Voters Card',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraScreen(
                            payload: payload,
                            documentType: "votersCard",
                          )));
                  // Handle tap
                },
              ),
              _buildListTile(
                title: 'NIN',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraScreen(
                            payload: payload,
                        documentType: "nin",
                          )));
                  // Handle tap
                },
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEEFD6), // Light orange background
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lock, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Your ID photo will be stored securely.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      onTap: onTap,
    );
  }
}
