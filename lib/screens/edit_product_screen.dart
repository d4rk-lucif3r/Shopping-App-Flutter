import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-productScreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
      id: null, title: null, description: null, price: null, imageUrl: null);
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  bool _imageValidator(String givenUrl) {
    if ((!givenUrl.startsWith('http') && !givenUrl.startsWith('https')) ||
        (!givenUrl.endsWith('.jpg') &&
            !givenUrl.endsWith('.png') &&
            !givenUrl.endsWith('.jpeg'))) {
      return false;
    }
    return true;
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      Provider.of<ProductsProviders>(context, listen: false)
          .addProduct(_editedProduct);
      Navigator.of(context).pop();
    }
  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  Widget _builderTextWidget({
    String textValue,
    bool istitle = false,
    bool isPrice = false,
    bool isDescription = false,
    bool isUrl = false,
  }) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: textValue,
        ),
        textInputAction: isUrl
            ? TextInputAction.done
            : isDescription
                ? TextInputAction.newline
                : TextInputAction.next,
        keyboardType: isUrl
            ? TextInputType.url
            : isPrice
                ? TextInputType.number
                : TextInputType.name,
        maxLines: isDescription ? 3 : 1,
        controller: isUrl ? _imageUrlController : null,
        focusNode: isUrl ? _imageUrlFocusNode : null,
        onFieldSubmitted: (_) {
          if (isUrl) {
            _saveForm();
          }
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a $textValue.';
          }

          /* For Price */
          if (isPrice) {
            if (value.isEmpty) {
              return 'Please Provide a $textValue.';
            }
            if (double.tryParse(value) == null) {
              return 'Please Provide a Valid Number';
            }
            if (double.parse(value) <= 0) {
              return 'Please a enter a number greater than 0';
            }
          }
          /* For Description */
          if (isDescription) {
            if (value.isEmpty) {
              return 'Please Provide a $textValue.';
            }
            if (value.length < 10) {
              return 'Should be atleast 10 characters long';
            }
          }
          if (isUrl) {
            if (value.isEmpty) {
              return 'Please Provide a $textValue.';
            }
            if (!value.startsWith('http') && !value.startsWith('https')) {
              return 'Please enter a Valid Url';
            }
            if (!value.endsWith('.jpg') &&
                !value.endsWith('.png') &&
                !value.endsWith('.jpeg')) {
              return 'Please enter a Valid Url. Accepts only jpg,jpeg,png';
            }
          }
          return null;
        },
        onSaved: (value) {
          if (istitle) {
            _editedProduct = Product(
                id: null,
                title: value,
                description: _editedProduct.description,
                price: _editedProduct.price,
                imageUrl: _editedProduct.imageUrl);
          }
          if (isDescription) {
            _editedProduct = Product(
                id: null,
                title: _editedProduct.title,
                description: value,
                price: _editedProduct.price,
                imageUrl: _editedProduct.imageUrl);
          }
          if (isPrice) {
            _editedProduct = Product(
                id: null,
                title: _editedProduct.title,
                description: _editedProduct.description,
                price: double.parse(value),
                imageUrl: _editedProduct.imageUrl);
          }
          if (isUrl) {
            _editedProduct = Product(
                id: null,
                title: _editedProduct.title,
                description: _editedProduct.description,
                price: _editedProduct.price,
                imageUrl: value);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Card(
        elevation: 15,
        shadowColor: Colors.blueGrey,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _form,
            child: ListView(
              children: <Widget>[
                _builderTextWidget(textValue: 'Title', istitle: true),
                _builderTextWidget(textValue: 'Price', isPrice: true),
                _builderTextWidget(
                  textValue: 'Description',
                  isPrice: false,
                  isDescription: true,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        )),
                        child: _imageUrlController.text.isEmpty
                            ? Text(
                                'No URL added',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                ),
                              )
                            : !_imageValidator(_imageUrlController.text)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                      child: Center(
                                          child: Text(
                                        'Enter valid url',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).errorColor),
                                      )),
                                    ),
                                  )
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                    Expanded(
                        child: _builderTextWidget(
                            textValue: 'Image Url', isUrl: true)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
