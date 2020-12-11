import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-productScreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
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

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  Widget _builderTextWidget({
    String title,
    bool numberKeys = false,
    bool description = false,
    bool url = false,
  }) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: title,
        ),
        textInputAction: url
            ? TextInputAction.done
            : description
                ? TextInputAction.newline
                : TextInputAction.next,
        keyboardType: url
            ? TextInputType.url
            : numberKeys
                ? TextInputType.number
                : TextInputType.name,
        maxLines: description ? 3 : 1,
        controller: url ? _imageUrlController : null,
        focusNode: url ? _imageUrlFocusNode : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
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
            child: ListView(
              children: <Widget>[
                _builderTextWidget(title: 'Title', numberKeys: false),
                _builderTextWidget(title: 'Price', numberKeys: true),
                _builderTextWidget(
                  title: 'Description',
                  numberKeys: false,
                  description: true,
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
                        child:
                            _builderTextWidget(title: 'Image Url', url: true)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
