import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/models/product.dart';
import 'package:shopify/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductStateScreen createState() => _EditProductStateScreen();
}

class _EditProductStateScreen extends State<EditProductScreen> {
  String _imageUrlInput = '';
  bool _isImageUrlValid = false;
  final _formKey = GlobalKey<FormState>();

  var _editProductData = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editProductData = Provider.of<ProductProvider>(context, listen: false)
            .findbyId(productId);
      }
    } else {
      _isInit = false;
    }
  }

  void _onPressedSave() async {
    _formKey.currentState.save();
    setState(() => _isLoading = true);
    if (_editProductData.id != null) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editProductData);
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    } else {
      final response =
          await Provider.of<ProductProvider>(context, listen: false)
              .addProduct(_editProductData);
      if (response['error'] != null) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Something Error!!'),
                content: Text('Are you sure want to back screen'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OKAY'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            });
      }
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    }
  }

  var urlPattern =
      r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _onPressedSave,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _editProductData.title,
                      decoration: InputDecoration(labelText: 'Title'),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      validator: (value) {
                        if (value.isEmpty) return 'This field is required';
                        if (value.length <= 2)
                          return 'Title length should be greater than 2';
                        _editProductData = Product(
                          id: _editProductData.id,
                          isFavourites: _editProductData.isFavourites,
                          title: value,
                          description: _editProductData.description,
                          imageUrl: _editProductData.imageUrl,
                          price: _editProductData.price,
                        );
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _editProductData.price.toString(),
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) return 'This field is required';
                        if (double.tryParse(value) <= 0)
                          return 'Price must be greater than 0';
                        _editProductData = Product(
                          id: _editProductData.id,
                          isFavourites: _editProductData.isFavourites,
                          title: _editProductData.title,
                          description: _editProductData.description,
                          imageUrl: _editProductData.imageUrl,
                          price: double.parse(value),
                        );
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _editProductData.description,
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) return 'This field is required';
                        if (value.length <= 6)
                          return 'Description must be greater than 6';
                        _editProductData = Product(
                          id: _editProductData.id,
                          isFavourites: _editProductData.isFavourites,
                          title: _editProductData.title,
                          description: value,
                          imageUrl: _editProductData.imageUrl,
                          price: _editProductData.price,
                        );
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Image.network(_imageUrlInput),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: _editProductData.imageUrl,
                            decoration: InputDecoration(labelText: 'Image'),
                            onChanged: (value) => setState(() {
                              _imageUrlInput = value;
                              var result = value.contains(
                                  new RegExp(urlPattern, caseSensitive: false),
                                  0);
                              _isImageUrlValid = result;
                            }),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'This field is required';
                              if (!_isImageUrlValid)
                                return 'Please enter valid image url';
                              _editProductData = Product(
                                id: _editProductData.id,
                                isFavourites: _editProductData.isFavourites,
                                title: _editProductData.title,
                                description: _editProductData.description,
                                imageUrl: value,
                                price: _editProductData.price,
                              );
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
