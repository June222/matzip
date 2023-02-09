import 'package:busan_univ_matzip/constants/res.dart';
import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:busan_univ_matzip/resources/auth_method.dart';
import 'package:busan_univ_matzip/screen/login_bottom_sheet.dart';
import 'package:busan_univ_matzip/widgets/custom_indicator.dart';
import 'package:busan_univ_matzip/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import '../../widgets/form/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onToggle;
  const LoginScreen({super.key, this.onToggle});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Duration _animationDuration = const Duration(milliseconds: 300);

  late final AnimationController _sizeAnimationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );
  late Animation<double> _sizeAnimation =
      Tween(begin: 1.0, end: 0.87).animate(_sizeAnimationController);

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

    _sizeAnimation =
        Tween(begin: 1.0, end: 0.93).animate(_sizeAnimationController);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _sizeAnimationController.dispose();
    super.dispose();
  }

  void _onTapDown() {
    FocusScope.of(context).unfocus();
    setState(() {
      _sizeAnimationController.forward();
    });
  }

  void _onTapUp() async {
    setState(() {
      _sizeAnimationController.reverse();
      _isLoading = true;
    });
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500), () => 12);
      _errorCheck = true;
    } else {
      await Future.delayed(const Duration(seconds: 3), () => 12);
      loginUser();
    }
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
      _errorCheck = true;
      showSnackBar(res, context);
    }
  }

  final ImageManager _imageManager = ImageManager();
  @override
  Widget build(BuildContext context) {
    final authIcons = _imageManager.icons;
    return GestureDetector(
        onTap: _onScaffoldTap,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/picnic.jpg'),
            ),
          ),
          child: Scaffold(
              appBar: AppBar(
                  title: const Text(
                    "Login (Test)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white.withOpacity(0.7), width: 2),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white.withOpacity(0.8)),
                      child: Column(children: [
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        const Text(
                          "Login Screen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        CutomTextFormField(
                          textEditingController: _emailController,
                          icon: authIcons['email'],
                          labeText: "이메일",
                          hintText: "Enter your e-mail",
                          errorCheck: _errorCheck,
                        ),
                        CutomTextFormField(
                          textEditingController: _passwordController,
                          icon: authIcons['password'],
                          labeText: "비밀번호",
                          hintText: "Enter your password",
                          obscureText: true,
                          errorCheck: _errorCheck,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: GestureDetector(
                            onTapUp: (details) => _onTapUp(),
                            onTapDown: (details) => _onTapDown(),
                            child: ScaleTransition(
                              scale: _sizeAnimation,
                              child: AnimatedContainer(
                                duration: _animationDuration,
                                alignment: Alignment.center,
                                padding: _emailController.text.isNotEmpty &&
                                        _passwordController.text.isNotEmpty
                                    ? const EdgeInsets.all(12.0)
                                    : const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    gradient: _emailController
                                                .text.isNotEmpty &&
                                            _passwordController.text.isNotEmpty
                                        ? LinearGradient(colors: [
                                            Colors.yellow.withOpacity(0.84),
                                            Colors.red.shade400.withOpacity(0.6)
                                          ])
                                        : LinearGradient(colors: [
                                            Colors.white.withOpacity(0.6),
                                            Colors.white.withOpacity(0.6)
                                          ]),
                                    // color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text("Login",
                                    style: TextStyle(
                                      color: _emailController.text.isNotEmpty &&
                                              _passwordController
                                                  .text.isNotEmpty
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        CustomIndicator(offstage: !_isLoading),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        )
                      ]),
                    ),
                  )),
              bottomSheet: const LoginBottomSheet()),
        ));
  }
}
