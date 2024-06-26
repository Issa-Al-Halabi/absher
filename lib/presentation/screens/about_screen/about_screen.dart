
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../bloc/about_bloc/about_bloc.dart';
import '../../../bloc/about_bloc/about_event.dart';
import '../../../bloc/about_bloc/about_state.dart';
import '../../../core/services/services_locator.dart';

import '../../widgets/custom_app_bar_screens.dart';
import '../../widgets/custom_error_screen.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutBloc>(
      create: (BuildContext context) => sl<AboutBloc>()..add(GetAbout()),
      // lazy: false,
      child: const AboutBody(),
    );
  }
}

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primaryColor,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBarScreens(
                title: AppLocalizations.of(context)!.about,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: BlocBuilder<AboutBloc, AboutState>(
                      builder: (context, state) {
                    if (state is AboutLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: ColorManager.primaryColor,
                      ));
                    } else if (state is AboutError) {
                      return CustomAppBackGround(

                        child: CustomErrorScreen(
                          onTap: () {
                            sl<AboutBloc>().add(GetAbout());
                          },
                        ),
                      );
                    } else if (state is AboutSuccess) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Html(
                                  data: state.content,
                                )
                              ]),
                        ),
                      );
                    } else {
                      return const Text("");
                    }
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
