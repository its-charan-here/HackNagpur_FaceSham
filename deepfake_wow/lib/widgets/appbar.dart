import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  File sampleImage;
  Future getImage() async {
    var tempImage = await ImagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: RaisedButton(color:Theme.of(context).primaryColor,elevation: 0,child:Text('Face Sham',style: TextStyle(color: Colors.white,fontSize: 20),),onPressed: (){Navigator.pushNamed(context,'/home');}),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: FlatButton(
            onPressed: getImage,
            child: Icon(
              Icons.cloud_upload,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
