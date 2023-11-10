import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Post/post_method.dart';
import 'package:healthcare_app/Providers/provider.dart';
import 'package:healthcare_app/models/user.dart';
import 'package:healthcare_app/utils/colors.dart';
import 'package:healthcare_app/utils/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  bool isLoading = false;
  void postImage(
    String uid,
    String name,
    String profileImage,
    DateTime datePublished,
  ) async {
    setState(() {
      isLoading == true;
    });
    try {
      String res = await postMethod().uploadPost(
        description: _descriptionController.text,
        uid: uid,
        name: name,
        profileImage: profileImage,
        datePublished: datePublished,
        file: _file!,
      );
      if (res == 'success') {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          'posted!',
          context,
        );
        clearImage();
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.only(top: 0),
                child: const Text('Take Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.only(top: 0),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.only(top: 0),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print("User current id is ${userId}");
    if (userId != null) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchCurrentUser(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final Users currentUser = userProvider.getCurrentUser;

    // @override
    // Widget build(BuildContext context) {
    //   final userProvider = Provider.of<UserProvider>(context);
    //   final Users? currentUser = userProvider.currentUser;

    return _file == null
        ? Material(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.upload),
                onPressed: () => _selectImage(context),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
                backgroundColor: mobileBackgroundColor,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: clearImage,
                ),
                title: const Text('Post to'),
                actions: [
                  TextButton(
                    onPressed: () => postImage(
                        currentUser.uid,
                        currentUser.name,
                        currentUser.photoUrl,
                        DateTime.now()), //attention here
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ]),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const LinearProgressIndicator()
                      : const Padding(
                          padding: EdgeInsets.only(
                          top: 0,
                        )),
                  const Divider(),
                  CircleAvatar(
                    backgroundImage: NetworkImage(currentUser.photoUrl),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Write your caption',
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                      controller: _descriptionController,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                ]),
          );
  }
}
