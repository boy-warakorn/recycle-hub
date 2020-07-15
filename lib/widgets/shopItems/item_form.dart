import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../models/user.dart';
import '../../helpers/item.dart';

import '../button/button.dart';

class ItemForm extends StatefulWidget {
  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  ItemService _item = ItemService();
  File _pickedImage;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  var _isLoading = false;

  var itemName = '';
  var itemPrice = '';
  var itemUnit = '';
  var itemDetail = '';

  void _pickImage() async {
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 400,
    );
    print(pickedImageFile.path);
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
  }

  void _trySubmit(userId) async {
    final isValid = _formKey.currentState.validate();
    if (_pickedImage == null) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please pick an image.',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      final userInfo =
          await Firestore.instance.collection('users').document(userId).get();
      final userFirstname = userInfo['firstname'];
      await _item.submitAddForm(
        userFirstname,
        itemName.trim(),
        itemPrice.trim(),
        itemUnit.trim(),
        itemDetail.trim(),
        _pickedImage,
        userId,
        context,
      );
      setState(() {
        _isLoading = false;
      });
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Item name",
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: ValueKey('itemName'),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(
                    10,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  hintText: 'Enter your item name',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                  ),
                ),
                validator: (value) {
                  if (value.length > 14) {
                    return 'Item name length must not more than 13';
                  } else if (value.trim() == '') {
                    return 'Item name must not be empty';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  itemName = value;
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Price per unit",
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: ValueKey('pricePerUnit'),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(
                    10,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  hintText: 'Enter your price',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                  ),
                ),
                validator: (value) {
                  if (value.trim() == '') {
                    return 'price can\'t be empty';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  itemPrice = value;
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Unit",
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: ValueKey('unit'),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(
                    10,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  hintText: 'Enter your item unit',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                  ),
                ),
                validator: (value) {
                  if (value.trim() == '') {
                    return 'item unit must not be empty';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  itemUnit = value;
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Item detail",
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLines: 3,
                key: ValueKey('itemDetail'),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(
                    10,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  hintText: 'Enter your item detail',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                  ),
                ),
                validator: (value) {
                  if (value.trim() == '') {
                    return 'item detail must not be empty';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  itemDetail = value;
                },
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: double.infinity,
            child: Button(
              buttonColor: Theme.of(context).primaryColor,
              text: "Add Picture",
              textColor: Colors.white,
              onClick: () {
                _pickImage();
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: Image(
              fit: BoxFit.fill,
              image: _pickedImage == null
                  ? AssetImage("assets/images/image_preview.png")
                  : FileImage(_pickedImage),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              !_isLoading
                  ? Container(
                      width: 200,
                      height: 60,
                      margin: EdgeInsets.only(
                        top: 20,
                        right: 10,
                      ),
                      child: Button(
                        text: 'Add item',
                        buttonColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onClick: () {
                          _trySubmit(user.uid);
                        },
                      ),
                    )
                  : Container(
                      height: 60,
                      width: 200,
                      margin: EdgeInsets.only(
                        top: 20,
                        right: 10,
                      ),
                      child: Button(
                        child: Text('asd'),
                        buttonColor: Color(0xFFEFFCEF),
                        textColor: Theme.of(context).primaryColor,
                        onClick: null,
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
