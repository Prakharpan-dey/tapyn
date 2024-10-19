import 'package:flutter/material.dart';
import 'package:tapyn/Pages/home_page.dart';
import 'package:tapyn/components.dart/my_button.dart';
import 'package:tapyn/components.dart/my_textfield.dart';
import 'package:tapyn/components.dart/squaretile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapyn/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final GestureTapCallback? onTap; // Callback to switch to LoginPage
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // Added controller

  @override
  void dispose() {
    // Dispose of the controllers
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose(); // Dispose of confirm password controller
    super.dispose();
  }

  // Sign user up method
  void signUserUp() async {
    // Validate input
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Try creating user
    try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Navigate to the next page upon successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      // Display the error message (using a SnackBar, for example)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      // Handle any other types of exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
    } finally {
      Navigator.pop(context); // Close the loading dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset('images/tapyn.png', height: 150, width: 200),
                const SizedBox(height: 10),
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 20),
                // Email TextField
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // Password TextField
                MyTextfield(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // Confirm Password TextField
                MyTextfield(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController, // Use the new controller
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // Sign Up Button
                MyButton(text: "Sign Up"
                ,onTap: signUserUp),
                const SizedBox(height: 15),
                // Or Continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or continue with", style: TextStyle(color: Colors.grey[700])),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Google/Apple Sign In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'images/google.png'),
                    const SizedBox(width: 25),
                    SquareTile(
                      onTap: () => {},
                      imagePath: 'images/apple.png'),
                  ],
                ),
                const SizedBox(height: 30),
                // Already have an account? Login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap, // Correctly call the onTap function
                      child: const Text(
                        'Login now',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
