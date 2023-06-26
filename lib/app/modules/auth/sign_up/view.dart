import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final _signUpController = Get.find<SignUpController>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _checkForm() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (firstName != '' && lastName != '' && email != '' && password != '') {
      await _signUpController.signUp(firstName, lastName, email, password);
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar("Sign Up", "All fields must be filled!",
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
      passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                  )),
              const SizedBox(height: 25),
              Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200]),
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  )),
              const SizedBox(height: 25),
              Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200]),
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Last Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  )),
              const SizedBox(height: 25),
              Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200]),
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
                      color: Colors.grey[200]),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  )),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.deepPurple),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    'Already registered?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text(
                      'Sign in here',
                      style: TextStyle(
                          color: Color(0xFF38bcc1),
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Get.toNamed('signIn');
                    },
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
