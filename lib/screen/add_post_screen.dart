import 'package:busan_univ_matzip/constants/res.dart';
import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/resources/firestore_method.dart';
import 'package:busan_univ_matzip/widgets/custom_indicator.dart';
import 'package:busan_univ_matzip/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _menuController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _tipController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  @override
  void dispose() {
    _menuController.dispose();
    _typeController.dispose();
    _priceController.dispose();
    _tipController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  Uint8List? image;
  bool isLoading = false;

  void _selectImage() async {
    image = await pickImage(ImageSource.gallery);
    setState(() {});
  }

  void _onPost(String uid, String username, String profileImage) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethod().uploadPost(
          _menuController.text,
          _infoController.text,
          _priceController.text,
          uid,
          image,
          username,
          profileImage);
      if (res == Res.successMsg) {
        showSnackBar("posted!", context);
      } else {
        showSnackBar(res, context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _selectImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          width: 200,
                          height: 200,
                          child: image == null
                              ? const Icon(
                                  Icons.camera_enhance_sharp,
                                  color: Colors.white,
                                )
                              : Image.memory(image!),
                        ),
                      ),
                      const SizedBox(height: 20),
                      PostScreenTextField(
                        typeController: _menuController,
                        labelText: "메뉴 이름",
                      ),
                      const SizedBox(width: 10),
                      PostScreenTextField(
                        typeController: _typeController,
                        labelText: "메뉴 타입",
                      ),
                      PostScreenTextField(
                        typeController: _priceController,
                        labelText: "가격",
                        suffixText: "원",
                      ),
                      PostScreenTextField(
                        typeController: _tipController,
                        labelText: "나만의 팁",
                        minLines: 1,
                        maxLines: 5,
                      ),
                      PostScreenTextField(
                        typeController: _infoController,
                        labelText: "후기",
                        minLines: 1,
                        maxLines: 10,
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
            isLoading
                ? const CustomIndicator(offstage: false)
                : TextButton(
                    onPressed: () => _onPost(
                          userProvider.getUser.uid,
                          userProvider.getUser.username,
                          userProvider.getUser.photoURL,
                        ),
                    child: const Text("게시"))
          ],
        ),
      ),
    );
  }
}

class PostScreenTextField extends StatelessWidget {
  const PostScreenTextField({
    super.key,
    required TextEditingController typeController,
    required String labelText,
    this.expands = false,
    this.suffixText = "",
    this.minLines = 1,
    this.maxLines = 1,
  })  : _labelText = labelText,
        _typeController = typeController;

  final TextEditingController _typeController;
  final String _labelText;
  final bool expands;
  final String suffixText;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    int? _maxLines = maxLines;
    // ignore: no_leading_underscores_for_local_identifiers
    int? _minLines = minLines;
    if (expands) {
      _maxLines = null;
      _minLines = null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Scrollbar(
        radius: Radius.zero,
        child: TextField(
          controller: _typeController,
          textInputAction: TextInputAction.newline,
          expands: expands,
          maxLines: _maxLines,
          minLines: _minLines,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            labelText: _labelText,
            labelStyle: const TextStyle(fontSize: 14),
            suffixText: suffixText,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
