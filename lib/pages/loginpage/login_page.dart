import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_see4me/pages/forgotpasswordpage/forgot_password_page.dart';
import 'package:project_see4me/pages/landingpage/landing_page.dart';
import 'package:project_see4me/provider/login_notifier.dart';
import 'package:project_see4me/utils/snack_message.dart';
import 'package:project_see4me/widgets/button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();

    void disposeControllers() {
      _email.dispose();
      _password.dispose();
    }

    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(),
      child: Consumer<LoginNotifier>(
        builder: (context, value, child) {
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
              title: const Text('Login'),
              backgroundColor: const Color(0xFF06192b),
              iconTheme: const IconThemeData(color: Colors.white),
              titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 200,
                    maxHeight: 400,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: customButton(
                              context: context,
                              buttonName: 'Login',
                              status: value.isLoading,
                              tap: () {
                                if (_email.text.isEmpty || _password.text.isEmpty) {
                                  showMessage(
                                    message: 'All fields are required',
                                    context: context,
                                  );
                                } else {
                                  value.login(
                                    email: _email.text.trim(),
                                    password: _password.text.trim(),
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
          );
        },
      ),
    );
  }
}
