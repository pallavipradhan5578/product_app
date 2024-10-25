import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:productap/Dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Key to validate the form
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Function to validate password
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 10) {
      return 'Password must be at least 10 characters';
    }
    return null;
  }

  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Show loader when login is clicked
      });

      try {
        Response response = await post(
          Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, 'password': password},
        );
        if (response.statusCode == 200) {
          print('Login successful');// From Page A, navigate to Page B and remove all previous routes
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
                (Route<dynamic> route) => false, // This removes all the previous routes
          );

        } else {
          print("Login failed");
        }
      } catch (e) {
        print(e.toString());
      }

      setState(() {
        isLoading = false; // Hide loader after API response
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2c4cff),
        title: const Text(
          'Login Page',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: _formKey, // Form key to track form state
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Enter Your Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return 'Please enter your email';// Email validation
                    }else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: passwordValidator, // Password validation
                  obscureText: true, // Hide password input
                ),
                const SizedBox(height: 40),
                isLoading
                    ? CircularProgressIndicator() // Show loader if isLoading is true
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2c4cff),
                    minimumSize: const Size(380, 50),
                  ),
                  onPressed: () {
                    login(
                      emailController.text.toString(),
                      passwordController.text.toString(),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 25, color: Colors.white),
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
