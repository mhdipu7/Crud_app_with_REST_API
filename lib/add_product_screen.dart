import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _titleTEController = TextEditingController();
  TextEditingController _unitPriceTEController = TextEditingController();
  TextEditingController _productCodeTEController = TextEditingController();
  TextEditingController _quantityTEController = TextEditingController();
  TextEditingController _totalPriceTEController = TextEditingController();
  TextEditingController _imageTEController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addProductInProgrress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTEController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Product Title",
                    labelText: "Produdct Title",
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Unite Price",
                    labelText: "Unit Price",
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Unite Price can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Product Code",
                    labelText: "Product Code",
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Product Code can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Quantity",
                    labelText: "Quantity",
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Product Quantity can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Total Price",
                    labelText: "Total Price",
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Product Total Price can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _imageTEController,
                  keyboardType: TextInputType.url,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Image Url",
                    labelText: "Image Url",
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Product Image Url can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _addProductInProgrress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addProduct();
                      }
                    },
                    child: Text("Add"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _addProduct() async {


  try{
    _addProductInProgrress = true;
    setState(() {});

    Map<String, dynamic> inputData = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text,
      "ProductName": _titleTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text,
    };
    const String addProductUrl =
        "https://crud.teamrabbil.com/api/v1/CreateProduct";
    Uri uri = Uri.parse(addProductUrl);
    Response response = await post(
      uri,
      body: jsonEncode(inputData),
      headers: {
        'content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      _titleTEController.clear();
      _unitPriceTEController.clear();
      _productCodeTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      _imageTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Succesfully New Product Added!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("New Product Added Faild Try Again!")));
    }

    _addProductInProgrress = false;
    setState(() {});
  } catch(e){
    print("Exception: ${e.toString()}");
  }


  }


  @override
  void dispose() {
    _titleTEController.dispose();
    _unitPriceTEController.dispose();
    _productCodeTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
