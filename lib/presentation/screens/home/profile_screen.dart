import 'package:flutter/material.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/domain/entities/auth/person.dart';
import 'package:salama_users/presentation/widgets/network_image.dart';

import '../../../core/alerts/__export.dart';
import '../../../core/routes/router_names.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Subscriptions',
            style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
              onPressed: () {
                context.auth.logout().then((_) {
                  context.nav.pushNamedAndRemoveUntil(
                      Routes.login, (Route<dynamic> route) => false);
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileInfo(context.auth.user.value!),
              const SizedBox(height: 10),
              _buildProfileOptions(context, context.auth.user.value),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(Person user) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            AppNetworkImage(
                url:
                    'https://res.cloudinary.com/duwmvd0zh/image/upload/v1715517981/30_kt4jfx.png',
                height: 80,
                width: 80),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName} ${user.middleName}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text('5.0 Rating'),
                  ],
                ),
                Text('${user.phone ?? ""}',
                    style: TextStyle(color: Colors.black54)),
                Text('${user.email ?? ""}',
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context, dynamic user) {
    return Column(
      children: [
        _buildListTile(
          context,
          Icons.person,
          'Personal Info',
          () {
            AppFlushbar.show('Error in accessing info. Contact Dev');
          },
        ),
        _buildListTile(
          context,
          Icons.privacy_tip,
          'Privacy',
          () {
            AppFlushbar.show('Error in accessing info. Contact Dev');
          },
        ),
        _buildListTile(
          context,
          Icons.settings,
          'Settings',
          () {
            AppFlushbar.show('Error in accessing info. Contact Dev');
          },
        ),
        _buildListTile(
          context,
          Icons.info_outline,
          'About',
          () {
            AppFlushbar.show('Error in accessing info. Contact Dev');
          },
        ),
        _buildListTile(
          context,
          Icons.person,
          'Delete Account',
          () {
            context.auth.deleteUser().then((_) {
              context.nav.pushNamedAndRemoveUntil(
                  Routes.login, (Route<dynamic> route) => false);
              AppFlushbar.show('Account deleted successfully', isError: false);
            });
          },
        ),
      ],
    );
  }

  Widget _buildListTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryGrey.withOpacity(0.5),
        child: Icon(
          icon,
          color: AppColors.dark,
          size: 20,
        ),
      ),
      title: Text(title,
          style: const TextStyle(color: AppColors.background, fontSize: 16)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: AppColors.background),
    );
  }
}
