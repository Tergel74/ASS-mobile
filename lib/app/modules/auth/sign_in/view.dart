import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upro/app/modules/auth/sign_in/controller.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final _signInController = Get.put<SignInController>(SignInController());

  // final emailController =
  //     TextEditingController(text: 'tergel.b24@tomujin.edu.mn');
  // final passwordController = TextEditingController(text: '24203');
  final emailController = TextEditingController(text: 'zayadelgerz@gmail.com');
  final passwordController = TextEditingController(text: '12345678');

  Future<void> _checkForm() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email != '' && password != '') {
      await _signInController.signIn(email, password);
      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar("Sign In", "All fields must be filled!",
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
      passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          top: true,
          bottom: true,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Welcome Back!', style: TextStyle(fontSize: 25)),
                const SizedBox(height: 25),
                Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white)),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                    )),
                const SizedBox(height: 25),
                Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white)),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                    )),
                const SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    child: const Text(
                      'Sign In',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    onPressed: () {
                      _checkForm();
                    },
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Not registered?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text(
                        'Sign up here',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          )),
        ));
  }
}
