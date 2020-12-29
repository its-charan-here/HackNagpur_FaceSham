import 'dart:convert';
import 'dart:io';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:video_player/video_player.dart';
import 'API.dart';
import 'aboutus.dart';

import 'widgets/chewie_list_item.dart';
import 'widgets/appbar.dart';
import 'widgets/drawer.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File imagefile;
  File sampleImage;

  File _video;

  var data;
  var uid;
  String queryText = '';
  String url = 'http://10.0.2.2:5000/api?id=';
  bool _loading;
  double _progressValue;
  Future getImage() async {
    final tempImage = await ImagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
      _video = File(sampleImage.path);
      _videoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController.play();
        });
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            width: 100,
            height: 100,
            child: _loading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: LiquidCircularProgressIndicator(
                            value: _progressValue, // Defaults to 0.5.
                            valueColor: AlwaysStoppedAnimation(Colors
                                .lightBlue), // Defaults to the current Theme's accentColor.
                            backgroundColor: Colors
                                .white, // Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.white,
                            borderWidth: 3.0,
                            direction: Axis
                                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                            center: Text("Loading..."),
                          ),
                        ),
                      )
                    ],
                  )
                : Text(''),
          ),
          SizedBox(
            height: 15,
          ),
          FloatingActionButton.extended(
            elevation: 7.0,
            label: Text(
              'Check!',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            icon: Icon(
              Icons.check,
              color: Theme.of(context).backgroundColor,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async {
              uid = new DateTime.now().millisecondsSinceEpoch;
              final Reference firebaseStorageRef =
                  FirebaseStorage.instance.ref().child(uid.toString() + '.mp4');
              print("Started Uploading!!");
              final UploadTask task = firebaseStorageRef.putFile(sampleImage);

              setState(() {
                _loading = !_loading;
                _updateProgress();
              });

              // sleep(const Duration(seconds: 5));
              print("Getting Data!");
              print(url + uid.toString());
              data = await Getdata(url + uid.toString());
              var decodedData = jsonDecode(data);
              setState(() {
                queryText = decodedData['Query'];
                print(queryText);
              });
            },
          ),
        ],
      ),
    );
  }

  VideoPlayerController _videoPlayerController;

  Color checkColor(String queryText) {
    Color defaultColor = Colors.grey[100];
    if (queryText == '1') {
      defaultColor = Color(0xFFe06666);
    } else if (queryText == '0') {
      defaultColor = Color(0xFF93c47d);
    }
    return defaultColor;
  }

  String giveResult(String queryText) {
    String modifiedText = '';
    if (queryText == '1') {
      modifiedText = 'It is a DeepFake Video';
    } else if (queryText == '0') {
      modifiedText = 'It is a true Video';
    }

    return modifiedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                    child: Text("DeepFake",
                        style: TextStyle(
                          color: Color(0xffe06666),
                          fontFamily: 'Oswald',
                          fontSize: 40,
                        )),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
                    child: Text("Detection",
                        style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontFamily: 'Oswald',
                            fontSize: 45)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                "Check for the counterfeit",
                style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontSize: 15,
                    fontFamily: 'Oswald'),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  "videos",
                  style: TextStyle(
                      color: Theme.of(context).errorColor,
                      fontSize: 15,
                      fontFamily: 'Oswald'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 230,
              color: Theme.of(context).canvasColor,
              child: sampleImage == null
                  ? Image.asset('assets/video_icon.png')
                  : ChewieListItem(
                      videoPlayerController: VideoPlayerController.file(_video),
                      looping: true,
                    ),
            ),
            Container(
              child: new Center(
                child: sampleImage == null
                    ? Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Select a Video",
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      )
                    : enableUpload(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            sampleImage == null
                ? Container(
                    child: FloatingActionButton.extended(
                      icon: Icon(
                        Icons.cloud_upload,
                        color: Theme.of(context).backgroundColor,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        'Upload',
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  )
                : Container(),
            SizedBox(height: 15),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: checkColor(queryText),
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      giveResult(queryText),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (_progressValue != 0.5) {
          _progressValue += 0.1;
        }

        if (data != null) {
          _progressValue = 1.0;
        }
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          return;
        }
      });
    });
  }
}
