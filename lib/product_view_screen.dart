import 'dart:convert';
import 'package:assignment4/add_product_screen.dart';
import 'package:assignment4/product_model.dart';
import 'package:assignment4/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  List<ProductModel> productList = [];

  bool _getProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        child: RefreshIndicator(
          onRefresh: () {
            return _getProductList();
          },
          child: Visibility(
            visible: _getProductInProgress == false,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.separated(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return _buildProductListItem(productList[index]);
              },
              separatorBuilder: (_, __) {
                return Divider(
                  color: Colors.transparent,
                  height: 8,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddProductScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _buildDeleteMessage(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: Text("Warning!"),
          ),
          content: Text("Do you want to delete this proudct?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                _deleteProduct("${product.id}");

                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );
  }

  Widget _buildProductListItem(ProductModel product) {
    return ListTile(
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          image: DecorationImage(
            image: NetworkImage(product.image ?? ""),
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(product.productName ?? "Unknown"),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text("Unit Price: ${product.unitPrice ?? ""}"),
          Text("Quantity: ${product.quantity ?? ""}"),
          Text("Total Price: ${product.quantity ?? ""}"),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProductScreen(
                    productModel: product,
                  ),
                ),
              );
              if (result == true) {
                _getProductList();
              }
            },
            icon: Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              _buildDeleteMessage(context, product);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getProductList() async {

  try{
    _getProductInProgress = true;
    setState(() {});

    productList.clear();
    const String url = "https://crud.teamrabbil.com/api/v1/ReadProduct";
    Uri uri = Uri.parse(url);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      final jsonProductList = decodeData['data'];
      for (Map<String, dynamic> json in jsonProductList) {
        ProductModel productModel = ProductModel.fromJson(json);
        productList.add(productModel);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Get product list faild! Try again..")));
    }
    _getProductInProgress = false;
    setState(() {});
  } catch(e){
    print("Exception: ${e.toString()}");
  }

  }

  Future<void> _deleteProduct(String productID) async {

    try{
      _getProductInProgress = true;
      setState(() {});

      String url = "https://crud.teamrabbil.com/api/v1/DeleteProduct/$productID";
      Uri uri = Uri.parse(url);
      Response response = await get(uri);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        _getProductList();
      } else {
        _getProductInProgress = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Get product list faild! Try again..")));
      }
    } catch(e){
      print("Exception : ${e.toString()}");
    }


  }
}
