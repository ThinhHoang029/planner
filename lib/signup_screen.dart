import 'package:daily_planner1/home_screen.dart';
import 'package:daily_planner1/login_screen.dart';
import 'package:daily_planner1/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe1f5fe), // Màu nền light blue
      appBar: AppBar(
        backgroundColor: const Color(0xff81d4fa), // Màu app bar
        title: const Text("Create Account"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'Đăng ký tài khoản',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Text(
              'Lên kế hoạch cho tương lai của bạn.',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            const SizedBox(height: 20),
            _buildTextField(_emailController, 'E-mail', Icons.email_outlined),
            const SizedBox(height: 20),
            _buildTextField(
                _passwordController, 'Password', Icons.lock_outline_rounded,
                isPassword: true),
            const SizedBox(height: 50),
            _buildElevatedButton(context),
            const SizedBox(height: 40),
            _buildDividerWithText(),
            const SizedBox(height: 20),
            _buildOutlinedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff81d4fa),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () async {
          User? user = await _auth.registerWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          );
          if (user == null) {
            _showErrorDialog(context);
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đăng ký thành công")));
          }
        },
        child: const Text('Đăng ký',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi'),
        content: const Text('Xin nhập thông tin đăng ký'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: const Text('Đăng nhập',
          style: TextStyle(fontSize: 22, color: Colors.black)),
    );
  }

  Widget _buildDividerWithText() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.black)),
        const Text('Hoặc đăng ký với', style: TextStyle(color: Colors.black)),
        Expanded(child: Divider(color: Colors.black)),
      ],
    );
  }
}
