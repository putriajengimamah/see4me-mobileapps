import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_see4me/pages/landingpage/landing_page.dart';
import 'package:project_see4me/provider/register_notifier.dart';
import 'package:project_see4me/utils/snack_message.dart';
import 'package:project_see4me/widgets/button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _fullname = TextEditingController();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final TextEditingController _confirmPassword = TextEditingController();

    // Cleanup controllers when widget is disposed
    void disposeControllers() {
      _fullname.dispose();
      _email.dispose();
      _password.dispose();
      _confirmPassword.dispose();
    }

    return ChangeNotifierProvider(
      create: (_) => RegisterNotifier(),
      child: Consumer<RegisterNotifier>(
        builder: (context, value, child) {
          // Display message if available
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (value.resMessage.isNotEmpty) {
              showMessage(
                message: value.resMessage,
                context: context,
              );

              value.clear();
            }
          });

          return Scaffold(
            backgroundColor: const Color(0xFF031A27),
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LandingPage()),
                  );
                },
                color: Colors.white,
              ),
              title: const Text('Register'),
              backgroundColor: const Color(0xFF06192b),
              iconTheme: const IconThemeData(color: Colors.white),
              titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 200,
                      maxHeight: 600,
                    ),
                    child: Card(
                      color: const Color(0xFF133039),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Name Field
                            TextField(
                              controller: _fullname,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: const Icon(Icons.person, color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.green),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 16),
                            // Email Field
                            TextField(
                              controller: _email,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email, color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.green),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 16),
                            // Password Field
                            TextField(
                              controller: _password,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.green),
                                ),
                              ),
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 16),
                            // Confirm Password Field
                            TextField(
                              controller: _confirmPassword,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.green),
                                ),
                              ),
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 16),
                            const SizedBox(height: 20),
                            // Register Button
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: customButton(
                                context: context,
                                buttonName: "Register",
                                status: value.isLoading,
                                tap: () {
                                  if (_fullname.text.isEmpty ||
                                      _email.text.isEmpty ||
                                      _password.text.isEmpty ||
                                      _confirmPassword.text.isEmpty) {
                                    showMessage(
                                      message: "All fields are required",
                                      context: context,
                                    );
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_email.text.trim())) {
                                    showMessage(
                                      message: "Enter a valid email",
                                      context: context,
                                    );
                                  } else if (_password.text.length < 6) {
                                    showMessage(
                                      message: "Password must be at least 6 characters",
                                      context: context,
                                    );
                                  } else if (_password.text != _confirmPassword.text) {
                                    showMessage(
                                      message: "Passwords do not match",
                                      context: context,
                                    );
                                  } else {
                                    value.registerUser(
                                      fullname: _fullname.text.trim(),
                                      email: _email.text.trim(),
                                      password: _password.text.trim(),
                                      confirmPassword: _confirmPassword.text.trim(),
                                      context: context,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
