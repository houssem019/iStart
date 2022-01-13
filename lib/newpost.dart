import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:istart/main.dart';
import 'package:istart/net/database.dart';
import 'package:istart/net/fbstorage.dart';
import 'package:video_player/video_player.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  var usersinfo = userprofilecords;
  var uid = DatabaseService().id();
  var textcontroller = TextEditingController();
  var date = DateTime.now().toString();
  List<XFile>? _PostFileList;

  set _PostFile(XFile? value) {
    _PostFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool isVideo = false;
  String? _retrieveDataError;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;

  final ImagePicker _Postpicker = ImagePicker();
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

  void _onPostImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _Postpicker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFileList = await _Postpicker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _PostFileList = pickedFileList;
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
          final pickedFile = await _Postpicker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _PostFile = pickedFile;
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

  Widget _previewPost() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_PostFileList != null) {
      return Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: kIsWeb
                    ? NetworkImage(_PostFileList![0].path)
                    : FileImage(File(_PostFileList![0].path)) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _PostFileList == null;
              });
            },
            icon: CircleAvatar(
              child: Icon(
                Icons.close,
                size: 26,
                color: Color.fromARGB(255, 46, 64, 84),
              ),
              backgroundColor: Color.fromARGB(255, 190, 210, 224),
            ),
          ),
        ],
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return SizedBox(
        height: 1,
      );
    }
  }

  Future<void> retrieveLostPost() async {
    final LostDataResponse response = await _Postpicker.retrieveLostData();
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
          _PostFile = response.file;
          _PostFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "Create Post",
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 46, 64, 84),
                ),
              ),
              onPressed: () {
                if (_PostFileList == null) {
                  DatabaseService()
                      .CreatePost(datetime: date, text: textcontroller.text);
                } else {
                  FbaseStorage().uploadPostimage(
                      _PostFileList![0], date, textcontroller.text);
                }
                Timer(Duration(milliseconds: 2500), () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                });
              },
              child: Text(
                "Post",
                style: TextStyle(
                  color: Color.fromARGB(255, 190, 210, 224),
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(usersinfo[uid]["image"]),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Text(
                    "${usersinfo[uid]["Name"]} ${usersinfo[uid]["surname"]}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 190, 210, 224),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color.fromARGB(255, 190, 210, 224),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: textcontroller,
                style: TextStyle(
                  color: Color.fromARGB(255, 190, 210, 224),
                ),
                decoration: InputDecoration(
                    hintText:
                        "What\'s your new idea ${usersinfo[uid]["Name"]} ?...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 190, 210, 224),
                        fontSize: 20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: FutureBuilder(
                  future: retrieveLostPost(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return SizedBox(
                          height: 1,
                        );
                      case ConnectionState.done:
                        return _previewPost();
                      default:
                        if (snapshot.hasError) {
                          return Text(
                            'Pick image: ${snapshot.error}}',
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return SizedBox(
                            height: 1,
                          );
                        }
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color.fromARGB(255, 190, 210, 224),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _onPostImageButtonPressed(ImageSource.gallery,
                          context: context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Color.fromARGB(255, 190, 210, 224),
                        ),
                        Text(
                          " Add Photos",
                          style: TextStyle(
                            color: Color.fromARGB(255, 190, 210, 224),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.tag,
                          color: Color.fromARGB(255, 190, 210, 224),
                        ),
                        Text(" Tags",
                            style: TextStyle(
                              color: Color.fromARGB(255, 190, 210, 224),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
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
