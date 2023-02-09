import 'package:busan_univ_matzip/model/user.dart';
import 'package:busan_univ_matzip/resources/auth_method.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  final AuthMethod _authMethod = AuthMethod();

  User get getUser => _user;

  Future<void> refereshUser() async {
    User user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
