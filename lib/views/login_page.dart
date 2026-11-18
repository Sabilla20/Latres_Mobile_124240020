import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userC = TextEditingController();
  final _passC = TextEditingController();
  final _auth = Get.find<AuthController>();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _userC.dispose();
    _passC.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_userC.text.trim().isEmpty || _passC.text.isEmpty) {
      Get.snackbar('Login', 'Username dan password wajib diisi',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    setState(() => _loading = true);
    final ok = await _auth.login(_userC.text, _passC.text);
    if (!ok && mounted) {
      setState(() => _loading = false);
      Get.snackbar('Login gagal', 'Username atau password salah',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.movie_creation, size: 72, color: primary),
                const SizedBox(height: 12),
                const Text(
                  'NontonSkuy!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 36),
                TextField(
                  controller: _userC,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username (NIM)',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _passC,
                  obscureText: _obscure,
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
