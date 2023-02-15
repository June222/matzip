import 'package:busan_univ_matzip/widgets/my_info_widget.dart';
import 'package:busan_univ_matzip/widgets/same_category_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _signOutCheck() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("진짜 하실 거?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("NoNo")),
          TextButton(onPressed: _signOut, child: const Text("YesYes")),
        ],
      ),
    );
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  // void _showAboutDialog() {
  //   showAboutDialog(
  //       context: context,
  //       applicationName: "오늘 머 먹지",
  //       applicationVersion: "1.2.3",
  //       applicationIcon: const Center(child: Icon(Icons.food_bank_outlined)));
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SameCategoryContainer(
            title: "내 정보",
            children: [
              MyInfoWidget(),
            ],
          ),
          SameCategoryContainer(
            title: "계정",
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("비밀번호 변경"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("이메일 변경"),
              )
            ],
          ),
          SameCategoryContainer(
            title: "커뮤니티",
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("닉네임 설정"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("프로필 이미지 변경"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("쪽지 설정"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("커뮤니티 이용 규칙"),
              ),
            ],
          ),
          SameCategoryContainer(
            title: "이용 안내",
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("앱 정보"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("회원 탈퇴"),
              ),
              TextButton(
                onPressed: _signOutCheck,
                child: const Text("로그아웃"),
              ),
            ],
          ),
          SameCategoryContainer(
            title: "기타",
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("정보 동의 설정"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("회원 탈퇴"),
              ),
              TextButton(
                onPressed: _signOutCheck,
                child: const Text("로그아웃"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
// data: const TextButtonThemeData(
//           style: ButtonStyle(
//             foregroundColor: MaterialStatePropertyAll(Colors.black),
//           ),
//         ),