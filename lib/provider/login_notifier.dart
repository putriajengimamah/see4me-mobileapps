import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_see4me/pages/mainpage/main_page.dart';
import 'package:project_see4me/provider/database_notifier.dart';
import 'package:project_see4me/utils/routers.dart';
import 'package:project_see4me/utils/url.dart';

class LoginNotifier extends ChangeNotifier {
  String baseUrl = AppUrl().baseUrl;
  String apiKey = AppUrl().apiKey;

  // Setter
  bool _isLoading = false;
  String _resMessage = '';

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  // Metode untuk login
  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$baseUrl/user/login";
    print(url);

    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$email:$password'));

    try {
      Map<String, String> headers = {
        'Authorization': basicAuth,
        'x-api-key': apiKey
      };
      http.Response req = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessage = "Login successful";
        notifyListeners();

        final token = res["token"];
        DatabaseProvider().saveToken(token);
        print(token);
        await Future.delayed(Duration(milliseconds: 300));
        PageNavigator(ctx: context).nextPageOnly(page: MainSee4MePage());
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
