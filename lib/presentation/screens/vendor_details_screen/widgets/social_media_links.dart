import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/formatter.dart';

class SocialMediaLinksSection extends StatelessWidget {
  const SocialMediaLinksSection({Key? key, required this.vendor})
      : super(key: key);
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(IconsManager.iconLinks),
            SizedBox(
              width: 8,
            ),
            Text(
              AppLocalizations.of(context)!.social,
              style: getRegularStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeApp.s12,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: vendor.socialMedia?.length,
                      itemBuilder: (context, index) {
                        return CachedImage(
                          imageUrl: vendor.socialMedia![index].image,
                          height: 50,
                          width: 50,
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.craatDate,
                style: getRegularStyle(
                  color: Colors.black,
                  fontSize: FontSizeApp.s12,
                ),
              ),
              Text(
                Formatter.formatDateOnly(context, vendor.customDate!),
                style: getBoldStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeApp.s12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
