import 'dart:io';

import 'package:amazon_clone/common/custom_elevatedButton.dart';
import 'package:amazon_clone/common/custom_textformfield.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    "Fashion"
  ];

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _addProductFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            images.isNotEmpty
                ? CarouselSlider(
                    items: images
                        .map((e) => Builder(
                            builder: (BuildContext context) => Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 200,
                                )))
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 200,
                    ),
                  )
                : GestureDetector(
                    onTap: selectImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Select Product Images",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              ),
                            ]),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
                controller: productNameController, hintText: "Product Name"),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: descriptionController,
              hintText: "Description",
              maxLines: 7,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(controller: priceController, hintText: "Price"),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                controller: quantityController, hintText: "Quantity"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButton(
                onChanged: (String? newVal) {
                  setState(() {
                    category = newVal!;
                  });
                },
                value: category,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: productCategories.map((String element) {
                  return DropdownMenuItem(value: element, child: Text(element));
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                onPressed: () {
                  sellProduct();
                },
                text: 'Add Product'),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      )),
    );
  }
}