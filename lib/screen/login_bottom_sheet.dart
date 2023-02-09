import 'package:flutter/material.dart';

class LoginBottomSheet extends StatefulWidget {
  final Function()? onToggle;
  const LoginBottomSheet({super.key, this.onToggle});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  void _signUpTap() {
    if (widget.onToggle != null) {
      widget.onToggle!();
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.1,
      child: BottomSheet(
        elevation: 2,
        enableDrag: false,
        onClosing: () {},
        builder: (context) => Container(
          alignment: Alignment.center,
          color: Colors.grey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("처음이신가요..? "),
              GestureDetector(
                onTap: _signUpTap,
                child: const Text(
                  "  회원가입  ",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
