import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../resources/values_app.dart';
import '../../../resources/assets_manager.dart';
import '../../story_screen/story_screen.dart';

class BuildStoreWidget extends StatelessWidget {
  const BuildStoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigationController.toStoryScreen(
        //   stories: stories,
        //   storyIndex: index,
        //   context: context,
        // );
        AppRouter.push(context, StoryScreen());
      },
      child: SizedBox(
        height: 95,
        child: ListView.builder(
          itemCount: 9,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(PaddingApp.p8),
              child: Container(
                height: 79,
                width: 79,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(RadiusApp.r50),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        ColorManager.circleStartColor,
                        ColorManager.circleEndColor,
                      ],
                    )),
                child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(RadiusApp.r50),
                      child: Image.asset(ImageManager.test)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
