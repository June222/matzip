import 'package:busan_univ_matzip/constants/res.dart';
import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:busan_univ_matzip/resources/auth_method.dart';
import 'package:busan_univ_matzip/screen/login_bottom_sheet.dart';
import 'package:busan_univ_matzip/widgets/custom_indicator.dart';
import 'package:busan_univ_matzip/widgets/form/custom_text_form_button.dart';
import 'package:busan_univ_matzip/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import '../widgets/form/custom_text_form.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onToggle;
  const LoginScreen({super.key, this.onToggle});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Duration _animationDuration = const Duration(milliseconds: 300);

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  bool _isLoading = false;
  bool _errorCheck = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonTap() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1), () => 12);
    _errorCheck = true;

    loginUser();

    setState(() {
      _isLoading = false;
    });
  }

  void _toHomePage() {
    Navigator.pushNamed(context, '/homePage');
  }

  void loginUser() async {
    String res = await AuthMethod().signinUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == Res.successMsg) {
      print("logged in");
      _toHomePage();
    } else {
      showSnackBar(res, context);
    }
  }

  final ImageManager _imageManager = ImageManager();
  @override
  Widget build(BuildContext context) {
    final authIcons = _imageManager.icons;
    bool filled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    return GestureDetector(
        onTap: _onScaffoldTap,
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(children: [
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      const Text(
                        "Login Screen",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      CutomTextFormField(
                        textEditingController: _emailController,
                        icon: authIcons['email'],
                        labelText: "이메일",
                        hintText: "Enter your e-mail",
                        errorCheck: _errorCheck,
                      ),
                      const SizedBox(height: 10),
                      CutomTextFormField(
                        textEditingController: _passwordController,
                        icon: authIcons['password'],
                        labelText: "비밀번호",
                        hintText: "Enter your password",
                        obscureText: true,
                        errorCheck: _errorCheck,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      CustomTextFormButton(
                        validated: filled,
                        onPressed: _onLoginButtonTap,
                        text: "Login",
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      CustomIndicator(offstage: !_isLoading),
                    ]),
                  ),
                )),
            bottomSheet: const LoginBottomSheet()));
  }
}
