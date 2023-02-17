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
        style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            padding: MaterialStatePropertyAll(EdgeInsets.zero)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          padding:
              validated ? const EdgeInsets.all(14.0) : const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: validated
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 18,
                      spreadRadius: 5,
                    )
                  ]
                : null,
            color: validated ? Theme.of(context).primaryColor : null,
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
