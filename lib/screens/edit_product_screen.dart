import 'package:flutter/material.dart';
import '../providers/product.dart';

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

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
    

  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  Widget _builderTextWidget({
    String title,
    bool istitle = false,
    bool isPrice = false,
    bool isDescription = false,
    bool isUrl = false,
  }) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: title,
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
            key: _form,
            child: ListView(
              children: <Widget>[
                _builderTextWidget(title: 'Title', istitle: true),
                _builderTextWidget(title: 'Price', isPrice: true),
                _builderTextWidget(
                  title: 'Description',
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
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                        child: _builderTextWidget(
                            title: 'Image Url', isUrl: true)),
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
