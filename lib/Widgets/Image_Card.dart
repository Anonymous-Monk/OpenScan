import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:openscan/Utilities/cropper.dart';
import 'package:openscan/Utilities/database.dart';

import '../Utilities/constants.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    this.imageFile,
    this.imageFileEditCallback,
    this.fileName,
    this.dirPath,
    this.folder,
  });

  final File imageFile;
  final Function imageFileEditCallback;
  final String fileName;
  final String dirPath;
  final Folder folder;

  @override
  Widget build(BuildContext context) {
    TransformationController _controller = TransformationController();
    print(dirPath);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width*0.012),
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        color: primaryColor,
        onPressed: () {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  elevation: 20,
                  backgroundColor: primaryColor,
                  child: InteractiveViewer(
                    transformationController: _controller,
                    maxScale: 10,
                    //TODO: Check
                    onInteractionEnd: (scaleEndDetails) {
                      _controller.value = Matrix4.identity();
                    },
                    child: GestureDetector(
                      onDoubleTap: () {
                        _controller.value = Matrix4.identity();
                      },
                      child: Container(
                        width: size.width * 0.95,
                        child: Image.file(
                          imageFile,
                          scale: 1.7,
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        child: Material(
          elevation: 5,
          child: Image.file(
            imageFile,
            height: size.width * 0.475,
            width: size.width * 0.475,
            fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}


//FocusedMenuItem(
//title: Text(
//'Crop',
//style: TextStyle(color: Colors.black),
//),
//onPressed: () async {
//// String imageFilePath = await FlutterScannerCropper.openCrop({
////   'src': imageFile.path,
////   'dest': '/data/user/0/com.ethereal.openscan/cache/'
//// });
//// File image = File(imageFilePath);
//Cropper cropper = Cropper();
//var image = await cropper.cropImage(imageFile);
//File temp = File(
//    imageFile.path.substring(0, imageFile.path.lastIndexOf(".")) +
//        "c.jpg");
//imageFile.deleteSync();
//if (image != null) {
//image.copy(temp.path);
//}
//imageFileEditCallback();
//},
//trailingIcon: Icon(
//Icons.crop,
//color: Colors.black,
//),
//),
//FocusedMenuItem(
//title: Text('Delete'),
//trailingIcon: Icon(Icons.delete),
//onPressed: () {
//showDialog(
//context: context,
//builder: (context) {
//return AlertDialog(
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.all(
//Radius.circular(10),
//),
//),
//title: Text('Delete'),
//content: Text('Do you really want to delete image?'),
//actions: <Widget>[
//FlatButton(
//onPressed: () => Navigator.pop(context),
//child: Text('Cancel'),
//),
//FlatButton(
//onPressed: () {
//imageFile.deleteSync();
//imageFileEditCallback();
////                            database.deleteImage(
////                                imgPath: imageFile.path, tableName: dirName);
////                            print(dirPath);
////                            print(Directory(dirPath).existsSync());
//try {
//Directory(dirPath).deleteSync(recursive: false);
//Navigator.pop(context);
//} catch (e) {
//imageFileEditCallback();
//}
////                            print(Directory(dirPath).existsSync());
////                            if (Directory(dirPath).existsSync()) {
//////                              imageFileEditCallback();
//////                              Navigator.pop(context);
////                            } else {
////                              Navigator.pop(context);
////                            }
////                            DatabaseHelper()..deleteDirectory(dirPath: dirPath);
//Navigator.pop(context);
//},
//child: Text(
//'Delete',
//style: TextStyle(color: Colors.redAccent),
//),
//),
//],
//);
//},
//);
//},
//backgroundColor: Colors.redAccent),