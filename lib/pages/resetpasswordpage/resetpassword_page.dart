import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_see4me/provider/reset_password_notifier.dart';
import 'package:project_see4me/utils/snack_message.dart';
import 'package:project_see4me/widgets/button.dart';
import '../forgotpasswordpage/forgot_password_page.dart';
import '../loginpage/login_page.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;

  const ResetPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _newPasswordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => ResetPasswordNotifier(),
      child: Consumer<ResetPasswordNotifier>(
        builder: (context, value, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (value.resMessage.isNotEmpty) {
              showMessage(
                message: value.resMessage,
                context: context,
              );

              if (value.isSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }

              value.clear();
            }
          });

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                  );
                },
                color: Colors.white,
              ),
              title: const Text('Reset Password'),
              backgroundColor: const Color(0xFF06192b),
              iconTheme: const IconThemeData(color: Colors.white),
              titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            backgroundColor: const Color(0xFF031A27),
            body: Center(
              child: SingleChildScrollView(
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
                              controller: _newPasswordController,
                              decoration: InputDecoration(
                                labelText: 'New Password',
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
                            TextField(
                              controller: _confirmPasswordController,
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
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: customButton(
                                context: context,
                                buttonName: 'Reset Password',
                                status: value.isLoading,
                                tap: () {
                                  if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
                                    showMessage(
                                      message: 'All fields are required',
                                      context: context,
                                    );
                                  } else if (_newPasswordController.text != _confirmPasswordController.text) {
                                    showMessage(
                                      message: 'Passwords do not match',
                                      context: context,
                                    );
                                  } else {
                                    value.resetPassword(
                                      email: email,
                                      newPassword: _newPasswordController.text,
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
