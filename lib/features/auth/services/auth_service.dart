import 'dart:convert';

import 'package:amazon_clone/common/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screen/home_screen.dart';
import 'package:amazon_clone/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user.dart';

class AuthService {
  void signUp(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
          address: '',
          email: email,
          id: '',
          name: name,
          password: password,
          token: '',
          type: '');
      http.Response res = await http.post(Uri.parse("${url}/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          onSuccess: () {
            showSnackbar(
                context, "Account created! Login with same credentials");
          },
          context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      http.Response response = await http.post(Uri.parse("$url/api/signin"),
          body: json.encode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
          response: response,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            await prefs.setString(
                'x-auth-token', json.decode(response.body)["token"]);
            Navigator.pushNamedAndRemoveUntil(
                context, ButtomNavBar.routeName, (route) => false);
          },
          context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void getData(BuildContext context) async {
    try {
      print('inside');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print(token);
      if (token == null) {
        token = '';
        await prefs.setString('x-auth-token', '');
      }
      http.Response tokenRes = await http
          .post(Uri.parse("$url/api/isTokenValid"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      });
      print(tokenRes.body);

      var response = jsonDecode(tokenRes.body);
      print(response);
      if (response == true) {
        http.Response user = await http.get(Uri.parse('$url/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        print(json.decode(user.body)["token"]);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(user.body);
        print(userProvider.user.token);
      }
    } catch (e) {
      print("in catch block");
      showSnackbar(context, e.toString());
    }
  }
}
