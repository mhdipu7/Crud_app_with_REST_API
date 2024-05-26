import 'dart:convert';

import 'package:assignment4/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({super.key, required this.productModel});

  ProductModel productModel;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  TextEditingController _titleTEController = TextEditingController();
  TextEditingController _unitPriceTEController = TextEditingController();
  TextEditingController _productCodeTEController = TextEditingController();
  TextEditingController _quantityTEController = TextEditingController();
  TextEditingController _totalPriceTEController = TextEditingController();
  TextEditingController _imageTEController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateProductInProgrress = false;

  @override
  void initState() {
    _titleTEController.text = widget.productModel.productName ?? '';
    _unitPriceTEController.text = widget.productModel.unitPrice ?? '';
    _productCodeTEController.text = widget.productModel.productCode ?? '';
    _quantityTEController.text = widget.productModel.quantity ?? '';
    _totalPriceTEController.text = widget.productModel.totalPrice ?? '';
    _imageTEController.text = widget.productModel.image ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
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
                  visible: _updateProductInProgrress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateProduct();
                      }
                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {

    try{
      _updateProductInProgrress = true;
      setState(() {});
      Map<String, String> inputData = {
        "Img": _imageTEController.text,
        "ProductCode": _productCodeTEController.text,
        "ProductName": _titleTEController.text,
        "Qty": _quantityTEController.text,
        "TotalPrice": _totalPriceTEController.text,
        "UnitPrice": _unitPriceTEController.text,
      };
      String updateProductUrl =
          "https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.productModel.id}";
      Uri uri = Uri.parse(updateProductUrl);
      Response response = await post(uri,
          headers: {'content-type': 'application/json'},
          body: jsonEncode(inputData));

      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product has been updated.")),
        );

        Navigator.pop(context, true);

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product Update faild! Try again.")),
        );
      }
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
