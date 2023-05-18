import 'package:absher/bloc/login_bloc/login_event.dart';
import 'package:absher/models/params/login_params.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/screens/home_screen/basic_screen.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/presentation/widgets/custom_loader.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../bloc/login_bloc/login_state.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_button.dart';


class SignInConfirmationScreen extends StatelessWidget {
  const SignInConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            LoadingDialog().openDialog(context);
          } else {
            LoadingDialog().closeDialog(context);
          }
          if (state is LoginError) {
            toast(state.error);
          }
          if(state is LoginConfirmed)
          { Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BasicScreen(),
              ),
            );}

        },
        child: _SignInScreen());
  }
}

class _SignInScreen extends StatelessWidget {
   _SignInScreen({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const LoginScreenBackGround(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 400,
                ),
                CustomInputField(
                  controller: phoneController,
                  hintText: 'أضف رقمك',
                  withLabel: true,
                  icon: Icons.phone_android,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomInputField(
                  controller: passwordController ,
                  hintText: AppLocalizations.of(context)!.password,
                  withLabel: true,
                  icon: Icons.lock_open_rounded,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomButton(label: 'تسجيل ',onTap: (){
                  sl<LoginBloc>()
                      .add(Login(loginParams: LoginParams(phone: phoneController.text,password: passwordController.text)));
                }),
              ],
            ),
          ),
        ),

      ],
    ));
  }
}
class LoginScreenBackGround extends StatelessWidget {
  const LoginScreenBackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomAppBackGround(
          child: SizedBox(),
        ),
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 320,
            ),
            Positioned(
              top: -5,
              right: -115,
              child: Container(
                width: 320,
                height: 320,
                decoration: const BoxDecoration(
                  color: ColorManager.softYellow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: ColorManager.shadowGrey,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: -120,
              child: Image.asset(
                ImageManager.signInAsset2,
                width: 320,
              ),
            ),
            Positioned(
              top: -165,
              left: -170,
              child: Container(
                width: 320,
                height: 320,
                decoration: const BoxDecoration(
                  color: ColorManager.softYellow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: ColorManager.shadowGrey,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -150,
              left: -170,
              child: Image.asset(
                ImageManager.signInAsset,
                width: 320,
              ),
            ),
          ],
        ),
      ],
    );
  }
}