import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../core/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profil'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: Colors.grey.shade800,
                child: const Icon(Icons.person, size: 48),
              ),
              const SizedBox(height: 16),
              Obx(() => Text(
                    auth.username.value,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 12),
              const Text('Kesan: $kKesan',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 4),
              const Text('Pesan: $kPesan',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: auth.logout,
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
