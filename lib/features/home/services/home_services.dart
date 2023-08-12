import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../global_variables.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
          Uri.parse('$url/api/products?category=$category'),
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

  Future<Product> fetchDealofDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
        name: '',
        description: '',
        quantity: 0,
        price: 0,
        category: '',
        images: []);
    try {
      http.Response response = await http
          .get(Uri.parse('$url/api/deal-of-the-day'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(
          response: response,
          onSuccess: () {
            product = Product.fromJson(response.body);
          },
          context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return product;
  }
}
