// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import 'package:flutter/material.dart';
import 'package:thrift_pantry/pages/login_register/forget_password.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _animation; 

  bool _isLoading = false;
  bool _obscurePassword = true; // Toggle for password visibility

  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize FirebaseAuth

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // void login() async {
  //   setState(() {
  //     _isLoading = true; // Start loading
  //   });

  //   try {
  //     // Sign in the user
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     // Login successful
  //     print('User signed in: ${userCredential.user?.email}');
  //     // Navigate to the HomePage with animation after successful login
  //     Navigator.of(context).pushAndRemoveUntil(
  //       PageRouteBuilder(
  //         pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
  //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //           var begin = const Offset(0.0, 1.0); // Start from the bottom
  //           var end = Offset.zero; // End at the center
  //           var curve = Curves.easeInOut; // Use ease in out curve

  //           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //           var offsetAnimation = animation.drive(tween);

  //           return SlideTransition(
  //             position: offsetAnimation,
  //             child: child,
  //           );
  //         },
  //         transitionDuration: const Duration(milliseconds: 500), // Duration of the transition
  //       ),
  //       (route) => false, // Remove all previous routes
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     // Handle errors here
  //     String errorMessage;
  //     if (e.code == 'user-not-found') {
  //       errorMessage = 'No user found for that email.';
  //     } else if (e.code == 'wrong-password') {
  //       errorMessage = 'Wrong password provided for that user.';
  //     } else {
  //       errorMessage = 'An error occurred. Please try again later.';
  //     }
  //     // Show error message in a dialog or snackbar
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text(errorMessage),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false; // Stop loading
  //     });
  //   }
  // }

  void login() async {
  setState(() {
    _isLoading = true; // Start loading
  });

  try {
    // Simulate a successful login without any conditions
    // Here, we will simply navigate to the HomePage
    // print('User signed in: ${emailController.text.trim()}');

    // Navigate to the HomePage with animation after successful login
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0); // Start from the bottom
          var end = Offset.zero; // End at the center
          var curve = Curves.easeInOut; // Use ease in out curve

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500), // Duration of the transition
      ),
      (route) => false, // Remove all previous routes
    );

    // You can simulate an error by throwing an exception if needed
    // For demonstration, uncomment the next line to simulate an error
    // throw Exception('Invalid credentials');

  } catch (e) {
    // Handle errors here
    String errorMessage = 'Login failed. Please try again.'; // General error message

    // Show error message in a dialog or snackbar
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } finally {
    setState(() {
      _isLoading = false; // Stop loading
    });
  }
}

  void forgotPassword() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ForgotPassword(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0); // Slide from right
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 150),
                Icon(
                  Icons.lock_open_rounded,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword; // Toggle password visibility
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: forgotPassword,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                _isLoading
                    ? const CircularProgressIndicator() // Show loading indicator if _isLoading is true
                    : MyButton(
                        name: 'Sign In',
                        onTap: login,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
