import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/translations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import '../../../bloc/authentication_bloc/authertication_bloc.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  bool isEditing;

  EditProfileScreen({super.key, this.isEditing = true});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    border:
                        Border.all(color: ColorManager.softYellow, width: 3),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Text(AppLocalizations.of(context)!.profile,
                            style: getBoldStyle(
                                color: Colors.white, fontSize: 14)),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInputField(
                          textStyle: const TextStyle(
                            color: ColorManager.primaryColor,
                          ),
                          initValue: context
                              .read<AuthenticationBloc>()
                              .loginResponse!
                              .name,
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          icon: Icons.person,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomInputField(
                          textStyle: const TextStyle(
                            color: ColorManager.primaryColor,
                          ),
                          initValue: context
                              .read<AuthenticationBloc>()
                              .loginResponse!
                              .email,
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          icon: Icons.email_rounded,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomInputField(
                          textStyle: const TextStyle(
                            color: ColorManager.primaryColor,
                          ),
                          initValue: context
                              .read<AuthenticationBloc>()
                              .loginResponse!
                              .phone,
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          icon: Icons.phone_android,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomInputField(
                          textStyle: TextStyle(
                            color: ColorManager.primaryColor,
                          ),
                          initValue: "10/2/1997",
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          icon: Icons.date_range,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomInputField(
                          textStyle: TextStyle(
                            color: ColorManager.primaryColor,
                          ),
                          initValue: "Female",
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          icon: Icons.people_alt_rounded,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomInputField(
                          textStyle: TextStyle(
                            color: ColorManager.primaryColor,
                          ),
                          initValue: "My favorite",
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          icon: Icons.favorite,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomInputField(
                          textStyle: TextStyle(
                            color: ColorManager.primaryColor,
                          ),
                          initValue: "*******",
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          icon: Icons.lock,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                border: Border.all(
                                    color: ColorManager.softYellow, width: 2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(ImageManager.faceBook),
                                Image.asset(ImageManager.email),
                                Image.asset(ImageManager.twitter),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Stack(
                children: [
                  const SizedBox(
                    height: 90,
                    width: 90,
                    child: CircularProgressIndicator(
                      value: 0.65,
                      backgroundColor: Colors.transparent,
                      valueColor:
                          AlwaysStoppedAnimation(ColorManager.softYellow),
                    ),
                  ),
                  Positioned(
                    top: 1,
                    bottom: 1,
                    right: 1,
                    left: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              ImageManager.profileTest,
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
