import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle(
    {required http.Response response,
    required VoidCallback onSuccess,
    required BuildContext context}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 500:
      showSnackbar(context, json.decode(response.body)["error"]);
      break;
    case 400:
      showSnackbar(context, jsonDecode(response.body)["msg"]);
      break;
    default:
      showSnackbar(context, response.body);
  }
}
