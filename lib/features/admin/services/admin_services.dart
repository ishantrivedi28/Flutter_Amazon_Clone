import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/global_variables.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dt0dzjb3n', 'zjn4clvd');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      var product = Product(
          name: name,
          description: description,
          quantity: quantity,
          price: price,
          category: category,
          images: imageUrls);
      http.Response response =
          await http.post(Uri.parse("$url/admin/addproduct"),
              headers: {
                'Content-type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: product.toJson());

      httpErrorHandle(
          response: response,
          onSuccess: () {
            showSnackbar(context, "Product Added Successfully");
            Navigator.pop(context);
          },
          context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http
          .get(Uri.parse('$url/admin/get-products'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });

      print("hello");
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

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.delete(Uri.parse("$url/admin/delete-product"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({'productId': product.id}));

      httpErrorHandle(
          response: response, onSuccess: onSuccess, context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
