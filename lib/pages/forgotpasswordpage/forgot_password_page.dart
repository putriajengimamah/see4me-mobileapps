import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_see4me/pages/loginpage/login_page.dart';
import 'package:project_see4me/provider/forgot_password_notifier.dart';
import 'package:project_see4me/utils/snack_message.dart';
import 'package:project_see4me/widgets/button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _email = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordNotifier(),
      child: Consumer<ForgotPasswordNotifier>(
        builder: (context, value, child) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
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
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                color: Colors.white, // Mengubah warna ikon back arrow
              ),
              title: const Text('Forgot Password'),
              backgroundColor: const Color(0xFF06192b),
              iconTheme: const IconThemeData(color: Colors.white), // Mengubah warna ikon back arrow
              titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20), // Mengubah warna teks title
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forgot Password',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: customButton(
                        context: context,
                        buttonName: "Submit",
                        status: value.isLoading,
                        tap: () {
                          if (_email.text.isEmpty) {
                            showMessage(
                              message: "Email is required",
                              context: context,
                            );
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_email.text.trim())) {
                            showMessage(
                              message: "Enter a valid email",
                              context: context,
                            );
                          } else {
                            value.forgotPassword(email: _email.text.trim(), context: context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
