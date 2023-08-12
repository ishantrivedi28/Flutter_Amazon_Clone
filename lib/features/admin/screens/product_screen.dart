import 'package:amazon_clone/common/loader.dart';
import 'package:amazon_clone/features/account/widgets/product_widget.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final AdminServices adminServices = AdminServices();
  List<Product>? productss;

  fetchallProducts() async {
    productss = await adminServices.fetchAllProduct(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          productss!.removeAt(index);
          setState(() {});
        });
  }

  @override
  void initState() {
    super.initState();
    fetchallProducts();
  }

  @override
  Widget build(BuildContext context) {
    return productss == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: productss!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = productss![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: ProductWidget(image: (productData.images)[0]),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                deleteProduct(productData, index);
                              },
                              icon: const Icon(Icons.delete_outline))
                        ],
                      )
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              tooltip: 'Add a product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
