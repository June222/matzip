import 'package:flutter/material.dart';

abstract class FieldControllers {
  static final TextEditingController _idController = TextEditingController();
  static final TextEditingController _pwController = TextEditingController();
  static final TextEditingController _fullnameController =
      TextEditingController();
  static final TextEditingController _usernameController =
      TextEditingController();

  static final bool _idFilled = _idController.text.isNotEmpty;
  static final bool _pwFilled = _pwController.text.isNotEmpty;
  static final bool _fnFilled = _fullnameController.text.isNotEmpty;
  static final bool _unFilled = _usernameController.text.isNotEmpty;

  TextEditingController get idController => _idController;
  TextEditingController get passwordController => _pwController;
  TextEditingController get fullnameController => _fullnameController;
  TextEditingController get usernameController => _usernameController;

  bool get loginCondition => _idFilled && _pwFilled;
  bool get signUpCondition => _idFilled && _pwFilled && _fnFilled && _unFilled;
}
