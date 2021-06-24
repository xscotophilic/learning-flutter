import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../app_drawer.dart';
import '../../../const.dart';
import '../../../providers/product.dart';
import '../../../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _colorFocusNode = FocusNode();
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': 0.0,
    'imageURL': '',
    'color': Color(0xFFFFFFFF),
  };

  var _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imageURL: '',
    color: Color(0x00FFFFFF),
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final prodID = ModalRoute.of(context)!.settings.arguments.toString();
      if (prodID != 'tinfoilhat') {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findByID(prodID);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageURL': '',
          'color': _editedProduct.color,
        };
        _imageUrlController.text = _editedProduct.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        drawer: AppDrawer(),
        body: Body(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            color: Theme.of(context).accentColor,
            width: 20,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        'Edit Product',
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
    );
  }

  Widget Body() {
    return Container(
      margin: EdgeInsets.all(Constants.kDefaultPaddin),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _initValues['title'] as String,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title.';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyText1,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: value as String,
                  description: _editedProduct.description,
                  price: _editedProduct.price,
                  imageURL: _editedProduct.imageURL,
                  color: _editedProduct.color,
                  isFavorite: _editedProduct.isFavorite,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _initValues['price'].toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a price.';
                  }
                  var urlPattern = r"^.*[,].*$";
                  final result = new RegExp(urlPattern, caseSensitive: false)
                      .firstMatch(value);
                  if (result != null) {
                    return 'Please remove comma.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a valid price.';
                  }

                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                style: Theme.of(context).textTheme.bodyText1,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  price: double.parse(value as String),
                  imageURL: _editedProduct.imageURL,
                  color: _editedProduct.color,
                  isFavorite: _editedProduct.isFavorite,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: _initValues['description'] as String,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a description.';
                  }
                  if (value.length < 10) {
                    return 'Description should be atleast 10 characters long.';
                  }
                  return null;
                },
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                style: Theme.of(context).textTheme.bodyText1,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_colorFocusNode),
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: value as String,
                  price: _editedProduct.price,
                  imageURL: _editedProduct.imageURL,
                  color: _editedProduct.color,
                  isFavorite: _editedProduct.isFavorite,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FittedBox(
                child: Text(
                  'Color should be in hex format (eg. ffffff or ffffffff or #ffffff).',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                initialValue: convertFromColor(_initValues['color'] as Color),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Background Color',
                ),
                style: Theme.of(context).textTheme.bodyText1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a color.';
                  }
                  var urlPattern = r"^[A-Za-z0-9_-]*$";
                  final result = new RegExp(urlPattern, caseSensitive: false)
                      .firstMatch(value);
                  if (result == null) {
                    return 'Please enter a valid hex color.';
                  }
                  return null;
                },
                focusNode: _colorFocusNode,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  price: _editedProduct.price,
                  imageURL: _editedProduct.imageURL,
                  color: convertToColor(value as String),
                  isFavorite: _editedProduct.isFavorite,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Image url',
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a URL.';
                        }
                        var urlPattern =
                            r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$";
                        final result =
                            new RegExp(urlPattern, caseSensitive: false)
                                .firstMatch(value);
                        if (result == null) {
                          return 'Please enter a valid URL.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _saveForm(),
                      onSaved: (value) => _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageURL: value as String,
                        color: _editedProduct.color,
                        isFavorite: _editedProduct.isFavorite,
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.all(Constants.kDefaultPaddin),
                    child: _imageUrlController.text.isEmpty
                        ? Text(
                            'Enter a URL first!',
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => _saveForm(),
                  icon: Icon(Icons.save),
                  label: Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editedProduct.id != 'tinfoilhat') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  Color convertToColor(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      return Color(int.parse("0xFF" + color));
    } else if (color.length == 8) {
      return Color(int.parse("0x" + color));
    }
    return Color(0xFFFFFFFF);
  }

  String convertFromColor(Color color) {
    String colorString = color.toString();
    return colorString.split('(0x')[1].split(')')[0];
  }
}
