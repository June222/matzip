import 'package:flutter/material.dart';

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
          textInputAction:
              maxLines == 1 ? TextInputAction.next : TextInputAction.newline,
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
