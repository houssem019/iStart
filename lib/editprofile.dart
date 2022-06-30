import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:istart/net/database.dart';
import 'package:istart/net/fbstorage.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var usersinfo = userprofilecords;
  var uid = DatabaseService().id();
  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  bool showindicator = false;
  List<XFile>? _ProfileFileList;

  set _ProfileFile(XFile? value) {
    _ProfileFileList = value == null ? null : [value];
  }

  List<XFile>? _CoverFileList;

  set _CoverFile(XFile? value) {
    _CoverFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool isVideo = false;
  String? _retrieveDataError;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;

  final ImagePicker _Profilepicker = ImagePicker();
  final ImagePicker _Coverpicker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      final double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  void _onProfileImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _Profilepicker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFileList = await _Profilepicker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _ProfileFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFile = await _Profilepicker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _ProfileFile = pickedFile;
            print("profilefile= ${_ProfileFileList![0].path}");
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  void _onCoverImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _Coverpicker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFileList = await _Coverpicker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _CoverFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFile = await _Coverpicker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _CoverFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  // Widget _previewVideo() {
  //   final Text? retrieveError = _getRetrieveErrorWidget();
  //   if (retrieveError != null) {
  //     return retrieveError;
  //   }
  //   if (_controller == null) {
  //     return const Text(
  //       'You have not yet picked a video',
  //       textAlign: TextAlign.center,
  //     );
  //   }
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: AspectRatioVideo(_controller),
  //   );
  // }

  Widget _previewProfile() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_ProfileFileList != null) {
      return CircleAvatar(
        radius: 80,
        // ignore: unnecessary_null_comparison
        backgroundImage: kIsWeb
            ? NetworkImage(_ProfileFileList![0].path)
            : FileImage(File(_ProfileFileList![0].path)) as ImageProvider,
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return CircleAvatar(
        radius: 80,
        // ignore: unnecessary_null_comparison
        backgroundImage: NetworkImage("${usersinfo[uid]["image"]}"),
      );
    }
  }

  Widget _previewCover() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_CoverFileList != null) {
      return Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 190, 210, 224),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
          image: DecorationImage(
            image: kIsWeb
                ? NetworkImage(_CoverFileList![0].path)
                : FileImage(File(_CoverFileList![0].path)) as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 190, 210, 224),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
          image: DecorationImage(
            image: NetworkImage("${usersinfo[uid]["cover"]}"),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Future<void> retrieveLostCover() async {
    final LostDataResponse response = await _Coverpicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _CoverFile = response.file;
          _CoverFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Future<void> retrieveLostProfile() async {
    final LostDataResponse response = await _Profilepicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _ProfileFile = response.file;
          _ProfileFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = usersinfo[uid]["Name"];
    surnameController.text = usersinfo[uid]["surname"];
    bioController.text = usersinfo[uid]["bio"];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 64, 84).withOpacity(1),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 55, 134, 150),
                Color.fromARGB(255, 190, 210, 224),
              ],
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (_ProfileFileList != null && _CoverFileList != null) {
                FbaseStorage().uploadProfileImage(_ProfileFileList![0]);
                FbaseStorage().uploadCoverImage(_CoverFileList![0]);
              } else if (_CoverFileList != null) {
                FbaseStorage().uploadCoverImage(_CoverFileList![0]);
              } else if ((_ProfileFileList != null)) {
                FbaseStorage().uploadProfileImage(_ProfileFileList![0]);
              } else {
                print("allllllllllllpppppppp");
                return;
              }
              setState(() {
                showindicator = true;
              });
              Timer(Duration(milliseconds: 5000), () {
                setState(() {
                  showindicator = false;
                  ;
                });
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.update,
                    size: 22,
                  ),
                  Text(
                    " Update",
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 64, 84),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        title: Text(
          "Edit profile",
          style: TextStyle(
            color: Color.fromARGB(255, 46, 64, 84),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              showindicator
                  ? LinearProgressIndicator(
                      color: Color.fromARGB(255, 190, 210, 224),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile Picture",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            FutureBuilder<void>(
                              future: retrieveLostProfile(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return CircleAvatar(
                                      radius: 80,
                                      // ignore: unnecessary_null_comparison
                                      backgroundImage: NetworkImage(
                                          "${usersinfo[uid]["image"]}"),
                                    );
                                  case ConnectionState.done:
                                    return _previewProfile();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text(
                                        'Pick image: ${snapshot.error}}',
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return CircleAvatar(
                                        radius: 80,
                                        // ignore: unnecessary_null_comparison
                                        backgroundImage: NetworkImage(
                                            "${usersinfo[uid]["image"]}"),
                                      );
                                    }
                                }
                              },
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    isVideo = false;
                                    _onProfileImageButtonPressed(
                                        ImageSource.gallery,
                                        context: context);
                                  },
                                  icon: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        Color.fromARGB(255, 190, 210, 224),
                                    child: Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 46, 64, 84),
                                    ),
                                  ),
                                  iconSize: 40,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Text(
                      "Cover photo",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          FutureBuilder<void>(
                            future: retrieveLostCover(),
                            builder: (context, AsyncSnapshot<void> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 190, 210, 224),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${usersinfo[uid]["cover"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                case ConnectionState.done:
                                  return _previewCover();
                                default:
                                  if (snapshot.hasError) {
                                    return Text(
                                      'Pick image: ${snapshot.error}}',
                                      textAlign: TextAlign.center,
                                    );
                                  } else {
                                    return Container(
                                      height: 140,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 190, 210, 224),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "${usersinfo[uid]["cover"]}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }
                              }
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              _onCoverImageButtonPressed(ImageSource.gallery,
                                  context: context);
                            },
                            icon: CircleAvatar(
                              radius: 40,
                              backgroundColor:
                                  Color.fromARGB(255, 190, 210, 224),
                              child: Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 46, 64, 84),
                              ),
                            ),
                            iconSize: 40,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: FormField(
                        builder: (context) => TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 190, 210, 224),
                          ),
                          // ignore: unnecessary_null_comparison
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 190, 210, 224),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 190, 210, 224),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              helperText: 'Enter your name',
                              hintText: 'Ex: Houssem',
                              helperStyle: TextStyle(
                                color: Color.fromARGB(255, 190, 210, 224),
                              ),
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 190, 210, 224),
                                  fontSize: 12)),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Text(
                      "Surname",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: FormField(
                        builder: (context) => TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 190, 210, 224),
                          ),
                          controller: surnameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 190, 210, 224),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 190, 210, 224),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              helperText: 'Enter your surname',
                              hintText: 'Ex: Yousfi',
                              helperStyle: TextStyle(
                                color: Color.fromARGB(255, 190, 210, 224),
                              ),
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 190, 210, 224),
                                  fontSize: 12)),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Surname must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Text(
                      "Bio",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 190, 210, 224),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: FormField(
                        builder: (context) => TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 190, 210, 224),
                          ),
                          controller: bioController,
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 190, 210, 224),
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 190, 210, 224),
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            helperText: 'Enter your Bio',
                            helperStyle: TextStyle(
                              color: Color.fromARGB(255, 190, 210, 224),
                            ),
                            hintText: 'Describe youself...',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 190, 210, 224),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_ProfileFileList != null &&
                                _CoverFileList != null) {
                              DatabaseService().updateUser(
                                  nameController.text,
                                  surnameController.text,
                                  ProfileImageUrl,
                                  CoverImageUrl,
                                  bioController.text);
                            } else if (_CoverFileList != null) {
                              DatabaseService().updateUser(
                                  nameController.text,
                                  surnameController.text,
                                  usersinfo[uid]["image"],
                                  CoverImageUrl,
                                  bioController.text);
                            } else if (_ProfileFileList != null) {
                              DatabaseService().updateUser(
                                  nameController.text,
                                  surnameController.text,
                                  ProfileImageUrl,
                                  usersinfo[uid]["cover"],
                                  bioController.text);
                            } else {
                              DatabaseService().updateUser(
                                  nameController.text,
                                  surnameController.text,
                                  usersinfo[uid]["image"],
                                  usersinfo[uid]["cover"],
                                  bioController.text);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check,
                                size: 20,
                                color: Color.fromARGB(255, 46, 64, 84),
                              ),
                              Text(
                                ' Save',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 46, 64, 84),
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 190, 210, 224),
                            ),
                            elevation: MaterialStateProperty.all(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 46, 64, 84),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 190, 210, 224),
                        ),
                        elevation: MaterialStateProperty.all(5.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      InputDecoration(hintText: "Enter maxWidth if desired"),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      InputDecoration(hintText: "Enter maxHeight if desired"),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: "Enter quality if desired"),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
