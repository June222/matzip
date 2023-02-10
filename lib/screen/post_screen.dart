import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _storeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _tipController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  @override
  void dispose() {
    _storeController.dispose();
    _typeController.dispose();
    _priceController.dispose();
    _tipController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.deepOrange, width: 1),
                ),
                width: 100,
                height: 100,
                child: const Icon(Icons.camera_enhance_sharp),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: PostScreenTextField(
                    typeController: _storeController,
                    labelText: "가게 이름",
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: PostScreenTextField(
                    typeController: _typeController,
                    labelText: "메뉴 타입",
                  ),
                ),
              ],
            ),
            PostScreenTextField(
              typeController: _priceController,
              labelText: "가격",
              suffixText: "원",
            ),
            PostScreenTextField(
              typeController: _tipController,
              labelText: "나만의 팁 (100자 이내)",
              maxLength: 100,
              minLines: 1,
              maxLines: 4,
            ),
            PostScreenTextField(
              typeController: _infoController,
              labelText: "후기",
              // expands: true,
            ),
          ]),
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
    this.maxLength,
  })  : _labelText = labelText,
        _typeController = typeController;

  final TextEditingController _typeController;
  final String _labelText;
  final bool expands;
  final String suffixText;
  final int minLines;
  final int maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    int? _maxLines = maxLines;
    // ignore: no_leading_underscores_for_local_identifiers
    int? _minLines = minLines;
    if (expands) {
      _maxLines = null;
      _minLines = null;
    } else if (_minLines > 1) {
      _maxLines = _minLines;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: TextField(
        controller: _typeController,
        // textAlignVertical: TextAlignVertical.bottom,
        textInputAction: TextInputAction.newline,
        maxLength: maxLength,
        expands: expands,
        maxLines: _maxLines,
        minLines: _minLines,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          constraints: BoxConstraints.loose(const Size.fromHeight(132)),
          labelText: _labelText,
          labelStyle: const TextStyle(fontSize: 14),
          suffixText: suffixText,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
