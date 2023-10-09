import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/widgets/reset_password_screen_background.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/presentation/widgets/custom_password_input_field.dart';
import 'package:absher/presentation/widgets/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../core/app_validators.dart';
import '../../../translations.dart';
import '../../widgets/dialogs/loading_dialog.dart';
import 'package:absher/presentation/screens/location_screen/widgets/app_bar_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            LoadingDialog().openDialog(context);
          } else {
            LoadingDialog().closeDialog(context);
          }
          if (state is SignUpError) {
            ErrorDialog.openDialog(context, state.error);
          }
          if (state is ResetPasswordCompleted) {
            AppRouter.pop(context);
          }
          if (state is SignUpFieldsValidationFailed) {
            toast(state.validationError!);
          }
        },
        child: _PhoneNumberSignUpScreenContent());
  }
}

class _PhoneNumberSignUpScreenContent extends StatelessWidget {
  _PhoneNumberSignUpScreenContent({Key? key}) : super(key: key);
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const ForgetPasswordScreenBackground(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  const SizedBox(
                    height: 400,
                  ),
                  Text(
                    AppLocalizations.of(context)!.changePassword,
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                      color: Colors.white,
                      fontSize: FontSizeApp.s22,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomPasswordInputField(
                    controller: oldPasswordController,
                    hintText: AppLocalizations.of(context)!.oldPassword,
                    withLabel: true,
                    icon: Icons.lock_open_rounded,
                    validator: (value) {
                      return AppValidators.validatePasswordFields(
                          context, value);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomPasswordInputField(
                    controller: passwordController,
                    hintText: AppLocalizations.of(context)!.newPassord,
                    withLabel: true,
                    icon: Icons.lock_open_rounded,
                    validator: (value) {
                      return AppValidators.validatePasswordFields(
                          context, value);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomPasswordInputField(
                    controller: repeatPasswordController,
                    hintText: AppLocalizations.of(context)!.confimPassword,
                    withLabel: true,
                    icon: Icons.lock_open_rounded,
                    validator: (value) {
                      return AppValidators.validateRepeatPasswordFields(
                          context, passwordController.text, value);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    label: AppLocalizations.of(context)!.next,
                    onTap: () {
                      if (_formState.currentState!.validate()) {
                        sl<SignUpBloc>().add(ResetPassword(
                            password: passwordController.text,
                            repeatPassword: repeatPasswordController.text,
                            oldPassword: oldPasswordController.text));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SafeArea(child: AppBarWidget())
      ],
    ));
  }
}
