import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/stars.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class SearchedProduct extends StatelessWidget {
  final Product searchedProduct;
  const SearchedProduct({super.key, required this.searchedProduct});

  @override
  Widget build(BuildContext context) {
    double myRating = 0;
    double avgRating = 0;

    double totalRating = 0;
    for (int i = 0; i < searchedProduct.ratings!.length; i++) {
      totalRating += searchedProduct.ratings![i].rating;
      if (searchedProduct.ratings![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = searchedProduct.ratings![i].rating;
      }
    }
    if (totalRating != 0)
      avgRating = totalRating / searchedProduct.ratings!.length;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Image.network(
              searchedProduct.images[0],
              fit: BoxFit.contain,
              height: 135,
              width: 135,
            ),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    searchedProduct.name,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Starss(
                    rating: avgRating,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "\$${searchedProduct.price}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "Eligible for FREE Shipping",
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: const Text(
                    "In Stock",
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ]),
        )
      ],
    );
  }
}
