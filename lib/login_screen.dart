import 'package:daily_planner1/home_screen.dart';
import 'package:daily_planner1/services/auth_service.dart';
import 'package:daily_planner1/signup_screen.dart';
import 'package:daily_planner1/widgets/custom_button.dart';
import 'package:daily_planner1/widgets/custom_signup.dart';
import 'package:daily_planner1/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Image(
                    image: AssetImage('assets/images/dailyplanning.png'),
                    width: 250,
                    height: 200,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Chào mừng trở lại',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'Lên kế hoạch cho tương lai của bạn',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: emailController,
                          labelText: 'E-Mail',
                          prefixIcon: const Icon(Icons.mail_outline,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 15),
                        CustomTextfield(
                          controller: passwordController,
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Colors.white),
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                              activeColor: Colors.white,
                            ),
                            const Text(
                              'Chọn ô để chúng tôi biết chính xác bạn là người!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          onButtonPressed: isChecked
                              ? () async {
                                  User? user =
                                      await _auth.signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  if (user != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Đăng nhập thành công")),
                                    );
                                  }
                                }
                              : null,
                          text: 'Đăng nhập',
                        ),
                        const SizedBox(height: 10),
                        CustomCreateaccount(
                          onSignUpPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          signUpText: "Tạo tài khoản",
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(
                                child: Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                    endIndent: 10)),
                            Text('Hoặc đăng nhập với',
                                style: TextStyle(color: Colors.white)),
                            Expanded(
                                child: Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                    indent: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
