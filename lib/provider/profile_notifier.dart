import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_see4me/utils/url.dart';
import 'package:project_see4me/pages/loginpage/login_page.dart'; // Tambahkan impor ini

class ProfileNotifier extends ChangeNotifier {
  String baseUrl = AppUrl().baseUrl;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? password,
    File? profileImage,
    required BuildContext context,
  }) async {
    setLoading(true);
    try {
      // Buat body request
      final Map<String, dynamic> requestBody = {
        'name': name,
        'email': email,
      };

      if (password != null && password.isNotEmpty) {
        requestBody['password'] = password;
      }

      if (profileImage != null) {
        requestBody['profileImage'] = base64Encode(profileImage.readAsBytesSync());
      }

      // Kirim request ke server
      final response = await http.post(
        Uri.parse('$baseUrl/updateProfile'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Berhasil update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Gagal update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Tangani error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setLoading(false);
    }
  }

  void logout(BuildContext context) {
    // Lakukan log out
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Perbarui baris ini
    );
  }

  void clear() {
    // Clear profile data
    notifyListeners();
  }
}
