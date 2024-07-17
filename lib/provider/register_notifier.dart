import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_see4me/pages/loginpage/login_page.dart';
import 'package:project_see4me/pages/mainpage/main_page.dart';
import 'package:project_see4me/utils/routers.dart';
import 'package:project_see4me/utils/url.dart';

class RegisterNotifier extends ChangeNotifier {
  String baseUrl = AppUrl().baseUrl;

  // Setter
  bool _isLoading = false;
  String _resMessage = '';

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String fullname,
    required String email,
    required String password,
    required String confirmPassword,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$baseUrl/user/register";
    print(url);

    final body = {
      "fullname": fullname,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword, // Changed key to match API
    };

    print(body);

    try {
      if (password != confirmPassword) {
        throw 'Passwords do not match';
      }

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      http.Response req = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessage = "Registration successful";
        notifyListeners();

        final token = res["token"];
        print(token);
        PageNavigator(ctx: context).nextPageOnly(page: LoginPage());
      } else {
        final res = jsonDecode(req.body);
        _resMessage = res['message'];
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Error: $e";
      notifyListeners();
    }
  }

  void clear() {
    _resMessage = '';
    notifyListeners();
  }
}
