import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/extensions.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/account_screen.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 AppLocalizations.of(context)!.hello,
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: FontSizeApp.s66,
                  )?.copyWith(height: 1.4),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.pushReplacement(context, const AccountScreen());
                  },
                  child: Container(
                    height: 54,
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: ColorManager.shadowGrey,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 47,
                            height: 47,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorManager.primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ).handleRotation(context),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.next,
                                style: getRegularStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: FontSizeApp.s26,
                                )?.copyWith(height: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Positioned(
              top: -25,
              left: -55,
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
              top: -30,
              left: -60,
              child: Image.asset(
                ImageManager.onBoarding1,
                width: 280,
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
