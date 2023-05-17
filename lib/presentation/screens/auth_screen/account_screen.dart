import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/screens/auth_screen/sign_in_screen.dart';
import 'package:absher/presentation/screens/auth_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CustomAppBackGround(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomButton(
                  fillColor: Colors.white,
                  labelColor: ColorManager.primaryColor,
                  label: 'تسجيل الدخول',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                CustomButton(
                  fillColor: Colors.white,
                  labelColor: Colors.white,
                  isFilled: false,
                  label: 'إنشاء حساب',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Positioned(
              top: -25,
              right: -55,
              child: Container(
                width: 280,
                height: 280,
                decoration: const BoxDecoration(
                  color: ColorManager.softYellow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: ColorManager.shadowGrey,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -32,
              right: -60,
              child: Image.asset(
                ImageManager.accountAsset,
                width: 280,
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
