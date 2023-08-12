import 'dart:convert';

import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../global_variables.dart';
import '../../../providers/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
          Uri.parse('$url/api/products/search/$searchQuery'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });

      httpErrorHandle(
          response: response,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ));
            }
          },
          context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productList;
  }
}
