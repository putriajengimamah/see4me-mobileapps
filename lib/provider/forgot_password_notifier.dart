import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_see4me/pages/resetpasswordpage/resetpassword_page.dart';
import 'package:project_see4me/utils/routers.dart';
import 'package:project_see4me/utils/url.dart';

class ForgotPasswordNotifier extends ChangeNotifier {
  String baseUrl = AppUrl().baseUrl;
  String apiKey = AppUrl().apiKey;

  // Setter
  bool _isLoading = false;
  String _resMessage = '';

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void forgotPassword({required String email, BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    String url = "$baseUrl/user/forgot-password";
    print(url);

    final body = {"email": email};
    print(body);

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-api-key': apiKey
      };
      http.Response req = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessage = "Password reset email sent";
        notifyListeners();

        // final token = res["token"];
        // print(token);
        // PageNavigator(ctx: context)
        //     .nextPageOnly(page: ResetPasswordPage(email: email));
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
