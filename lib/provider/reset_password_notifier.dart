import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_see4me/utils/url.dart';

class ResetPasswordNotifier extends ChangeNotifier {
  String baseUrl = AppUrl().baseUrl;

  // Setter
  bool _isLoading = false;
  String _resMessage = '';
  bool _isSuccess = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  bool get isSuccess => _isSuccess;

  void resetPassword({
    required String email,
    required String newPassword,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$baseUrl/user/reset-password";
    print(url);

    final body = {
      "email": email,
      "newPassword": newPassword,
    };
    print(body);

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      http.Response req = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        _isSuccess = true;
        _resMessage = "Password reset successfully";
        notifyListeners();
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
    _isSuccess = false;
    notifyListeners();
  }
}
