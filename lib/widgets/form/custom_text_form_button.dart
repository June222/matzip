import 'package:flutter/material.dart';

class CustomTextFormButton extends StatelessWidget {
  const CustomTextFormButton({
    super.key,
    required this.validated,
    required this.onPressed,
    required this.text,
  });

  final bool validated;
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: TextButton(
        onPressed: onPressed,
        style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          padding: validated
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: validated
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      offset: const Offset(0, 7),
                      blurRadius: 15,
                      spreadRadius: 5,
                    )
                  ]
                : null,
            color: validated ? Theme.of(context).primaryColor : Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    validated ? Colors.white : Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
