// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../_Globals/_GlobalMethods.dart';
import '../_Globals/imagesApi.dart';
import 'dart:developer';

import 'Home.dart';
import 'HomeScreen.dart';

class UploadQuiz extends StatefulWidget {
  const UploadQuiz({super.key});

  @override
  State<UploadQuiz> createState() => _UploadQuizState();
}

class _UploadQuizState extends State<UploadQuiz> {
  final _signupformkey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  File? image_file;
  final ImagePicker _picker = ImagePicker();
  final FocusNode _descfocus = FocusNode();
  bool _isloading = false;
  late CloudApi api;
  final TextEditingController _title = TextEditingController(text: '');
  final TextEditingController _description = TextEditingController(text: '');
  // String? imgUrl;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isUploaded = false;
  bool loading = false;
  String imageName = '';
  Uint8List? _imageBytes;
  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/credentials.json').then((json) {
      api = CloudApi(json);
    });
  }

  void _chooseImageOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please Choose An Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _getFilefromcamera(context);
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getFilefromgallery(context);
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _getFilefromcamera(BuildContext context) async {
    final XFile? imagepicked =
        await _picker.pickImage(source: ImageSource.camera);
    _CroppImage(imagepicked!.path);
    Navigator.pop(context);
  }

  void _getFilefromgallery(BuildContext context) async {
    final XFile? imagepicked =
        await _picker.pickImage(source: ImageSource.gallery);
    _CroppImage(imagepicked!.path);
    Navigator.pop(context);
  }

  void _CroppImage(filepath) async {
    CroppedFile? imagecropped = await ImageCropper()
        .cropImage(sourcePath: filepath, maxHeight: 1080, maxWidth: 1080);
    if (imagecropped != null) {
      setState(() {
        image_file = File(imagecropped.path);
        _imageBytes = image_file!.readAsBytesSync();
        imageName = image_file!.path.split('/').last;
      });
    }
  }

  void _submitform(BuildContext context) async {
    log("Submit Form");

    final isValid = _signupformkey.currentState!.validate();
    if (isValid) {
      log("Valid");
      // If image is not present, we dont continue
      if (image_file == null) {
        log("Image File Null");
        Global_Methods.showErrorBox(
          error: "Please Choose An Image",
          ctx: context,
        );
        return;
      } 
      
      setState(() {
        _isloading = true;
      });
    }

    try {
      log("Try");


      final response = await api.save(imageName, _imageBytes!);
      // log("${response.downloadLink}");
      final imgUrl = response.downloadLink;
      // log('Image File: $image_file');
      // log('Image path: ${image_file!.path}');
      // final User? user = FirebaseAuth.instance.currentUser;
      // final uid = user!.uid;
      // final ref = FirebaseStorage.instance
      //     .ref()
      //     .child('QuizImages')
          // .child(imageName);

      // await ref.putFile(image_file!);

      // final imgUrl = await ref.getDownloadURL();

      log("Image Url: $imgUrl");
      final refer = FirebaseFirestore.instance
      .collection('Quiz')
      .doc();
      var data1 = {
        'Description' : _description.text,
        'ImageUrl' : imgUrl.toString(),
        'Title' : _title.text,
      };
      await refer.set(data1, SetOptions(merge: true));
      log('Uploaded i assume');
      Navigator.canPop(context) ? Navigator.pop(context) : null;
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      Global_Methods.showErrorBox(error: e.toString(), ctx: context);
      log("Error Occured $e");
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizze = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const HomeScreen()));
            },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Form(
                    key: _signupformkey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _chooseImageOptions(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: sizze.width * 0.28,
                              height: sizze.width * 0.28,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: _imageBytes == null
                                    ? const Icon(
                                        Icons.camera_enhance_sharp,
                                        color: Colors.grey,
                                        size: 30,
                                      )
                                    : Image.memory(
                                        _imageBytes!,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Center(
                          child: SizedBox(
                            width: 300,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_descfocus),
                              keyboardType: TextInputType.name,
                              controller: _title,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Title!';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 0),
                                hintText: 'Enter Title',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                            width: 300,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              controller: _description,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Description!';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 0),
                                hintText: 'Enter Description',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _isloading
                            ? const Center(
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Center(
                                child: SizedBox(
                                  width: 300,
                                  height: 48,
                                  child: MaterialButton(
                                    onPressed: () {
                                      _submitform(context);
                                    },
                                    color: Colors.redAccent,
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Save",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
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
}
