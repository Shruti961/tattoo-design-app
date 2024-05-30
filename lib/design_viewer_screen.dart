import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DesignViewerScreen extends StatefulWidget {
  @override
  _DesignViewerScreenState createState() => _DesignViewerScreenState();
}

class _DesignViewerScreenState extends State<DesignViewerScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String _selectedGender = 'Gender';
  String _selectedBodyPart = 'Body Part';
  Offset _imageOffset = Offset(0.0, 0.0);
  double _imageRotation = 0.0;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _imageOffset = Offset(0.0, 0.0); // Reset image offset
      _imageRotation = 0.0; // Reset image rotation
    });
  }

  Widget _buildBodyPartImage() {
  double bodyPartImageSize = 250;

  if (_image == null) {
    return Center(
      child: Text('No image selected.'),
    );
  } else {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            _getBodyPartImagePath(),
            width: bodyPartImageSize,
            height: bodyPartImageSize,
          ),
          Positioned(
            left: _imageOffset.dx,
            top: _imageOffset.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _imageOffset += details.delta;
                });
              },
              child: Transform.rotate(
                angle: _imageRotation,
                child: Image.file(
                  File(_image!.path),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: CupertinoButton(
              onPressed: () {
                setState(() {
                  _imageRotation += 90 * (3.1415926535 / 180); // Rotate 90 degrees in radians
                });
              },
              child: Icon(CupertinoIcons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}


  String _getBodyPartImagePath() {
    String genderPrefix = _selectedGender == 'Male' ? 'male' : 'female';
    String bodyPart = _selectedBodyPart.toLowerCase();
    return 'asset/$genderPrefix/$bodyPart.jpeg';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('View Design'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.separator),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          title: Text('Select Gender'),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _selectedGender = 'Male';
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Male'),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _selectedGender = 'Female';
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Female'),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(_selectedGender),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.separator),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          title: Text('Select Body Part'),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _selectedBodyPart = 'Arm';
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Arm'),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _selectedBodyPart = 'Leg';
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Leg'),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _selectedBodyPart = 'Back';
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Back'),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _selectedBodyPart = 'Chest';
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Chest'),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(_selectedBodyPart),
                ),
              ),
              SizedBox(height: 16.0),
              CupertinoButton.filled(
                onPressed: _pickImage,
                child: Text('Upload from Camera Roll'),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: _buildBodyPartImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}