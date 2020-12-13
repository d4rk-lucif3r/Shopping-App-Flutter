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
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productID = ModalRoute.of(context).settings.arguments as String;
      if (productID != null) {
        _editedProduct = Provider.of<ProductsProviders>(context, listen: false)
            .findById(productID);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          //'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_editedProduct.id != null) {
        try {
          await Provider.of<ProductsProviders>(context, listen: false)
              .updateProduct(_editedProduct.id, _editedProduct);
        } catch (error) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text('An error Occured'),
              content: Text('Something Went Wrong While Editing'),
              actions: [
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
        }
      } else {
        try {
          await Provider.of<ProductsProviders>(context, listen: false)
              .addProduct(_editedProduct);
        } catch (error) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text('An error Occured'),
              content: Text('Something Went Wrong'),
              actions: [
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
        }
      }
      setState(() {
        _isLoading = false;
        Navigator.of(context).pop();
      });
    }
  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  //backgroundColor: Theme.of(context).accentColor,
                  ))
          : Card(
              elevation: 15,
              shadowColor: Colors.blueGrey,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(
                          labelText: 'Enter Title',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Title.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: value,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'],
                        decoration: InputDecoration(
                          labelText: 'Enter Price',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Provide a Price.';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please Provide a Valid Number';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please a enter a number greater than 0';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value),
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: InputDecoration(
                          labelText: 'Enter Description',
                        ),
                        textInputAction: TextInputAction.newline,
                        maxLines: 3,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Provide a Description.';
                          }
                          if (value.length < 10) {
                            return 'Should be atleast 10 characters long';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: value,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite,
                          );
                        },
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
                                                  color: Theme.of(context)
                                                      .errorColor),
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Enter Image Url',
                              ),
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Provide a Image Url.';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Please enter a Valid Url';
                                }
                                if (!value.endsWith('.jpg') &&
                                    !value.endsWith('.png') &&
                                    !value.endsWith('.jpeg')) {
                                  return 'Please enter a Valid Url. Accepts only jpg,jpeg,png';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: value,
                                  isFavorite: _editedProduct.isFavorite,
                                );
                              },
                            ),
                          )
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
