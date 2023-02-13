import 'dart:typed_data';

import 'package:busan_univ_matzip/constants/res.dart';
import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:busan_univ_matzip/resources/auth_method.dart';
import 'package:busan_univ_matzip/widgets/custom_indicator.dart';
import 'package:busan_univ_matzip/widgets/form/custom_text_form_button.dart';
import 'package:busan_univ_matzip/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/form/custom_text_form.dart';

class SignUpScreen extends StatefulWidget {
  final Function()? onToggle;
  const SignUpScreen({super.key, this.onToggle});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _isLoading = false;
  bool _errorCheck = false;

  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {});
    });
    _emailController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
    _fullnameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  bool _allFilled() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _fullnameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _image != null;
  }

  void _onTap() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2), () => 12);
    setState(() {
      _errorCheck = true;
    });

    signUpUser();

    setState(() {
      _isLoading = false;
    });
  }

  void signUpUser() async {
    if (_image == null) {
      showSnackBar("사진을 넣어주세용", context);
      return;
    }

    String res = await AuthMethod().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      fullname: _fullnameController.text,
      username: _usernameController.text,
      profilePicture: _image!,
    );

    if (res == Res.successMsg) {
      print("signed up");
      _toLoginScreen();
    } else {
      showSnackBar(res, context);
    }
  }

  void _toLoginScreen() {
    if (widget.onToggle != null) {
      widget.onToggle!();
    }
    Navigator.of(context).pop();
  }

  void _selectImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    Uint8List? img;
    if (file != null) {
      img = await file.readAsBytes();
    } else {
      img = null;
    }

    setState(() {
      _image = img;
    });
  }

  final ImageManager _imageManager = ImageManager();

  @override
  Widget build(BuildContext context) {
    final authIcons = _imageManager.icons;
    bool allFilled = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _fullnameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _image != null;

    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text("SignUp Screen",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                const SizedBox(height: 50),
                Stack(clipBehavior: Clip.none, children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.orange,
                          backgroundImage: NetworkImage(
                              "https://img.myloview.com/stickers/default-avatar-profile-vector-user-profile-400-200353986.jpg")),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: _selectImage,
                          splashRadius: 1,
                          icon: const Icon(Icons.add_a_photo_rounded),
                          iconSize: 30)),
                  Positioned(
                    bottom: -5,
                    left: -1,
                    child: Offstage(
                      offstage: !_errorCheck || _image != null,
                      child: const Text("choose any picture"),
                    ),
                  )
                ]),
                const SizedBox(height: 50),
                CutomTextFormField(
                  textEditingController: _emailController,
                  icon: authIcons["email"],
                  labelText: "e-mail",
                  hintText: "Enter yout e-mail",
                  errorCheck: _errorCheck,
                ),
                CutomTextFormField(
                  textEditingController: _passwordController,
                  icon: authIcons["password"],
                  labelText: "password",
                  hintText: "Enter your password",
                  obscureText: true,
                  errorCheck: _errorCheck,
                ),
                CutomTextFormField(
                  textEditingController: _fullnameController,
                  icon: authIcons['fullname'],
                  labelText: "full name",
                  hintText: "Enter your full name",
                  errorCheck: _errorCheck,
                ),
                CutomTextFormField(
                  textEditingController: _usernameController,
                  icon: authIcons['username'],
                  labelText: "user name",
                  hintText: "Enter your user name",
                  errorCheck: _errorCheck,
                ),
                const SizedBox(height: 35),
                CustomTextFormButton(
                  onPressed: _onTap,
                  validated: allFilled,
                  text: "Sign up",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomIndicator(offstage: !_isLoading),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
