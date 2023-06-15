import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

import 'info_details.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({Key? key, required this.vendor}) : super(key: key);
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoDetails(
          svgAsset: IconsManager.iconLocation,
          label:AppLocalizations.of(context)!.address,
          value: vendor.address,
        ),
        InfoDetails(
          svgAsset: IconsManager.iconLocation,
          label:AppLocalizations.of(context)!.address,
          value: vendor.address2,
        ),
        InfoDetails(
          svgAsset: IconsManager.iconPhone,
          label: AppLocalizations.of(context)!.phone,
          value: vendor.phone,
        ),
        InfoDetails(
          svgAsset: IconsManager.iconEmail,
          label:AppLocalizations.of(context)!.email,
          value: vendor.email,
        ),
        InfoDetails(
          svgAsset: IconsManager.iconWeb,
          label: AppLocalizations.of(context)!.web,
          value:  vendor.webiste,
        ),
      ],
    );
  }
}
