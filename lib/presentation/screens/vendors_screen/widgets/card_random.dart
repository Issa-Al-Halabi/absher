import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendor_details_screen/vendor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/localization_string.dart';
import '../../../../models/vendor_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../widgets/accessories/cached_image.dart';

class CardRandomWidget extends StatelessWidget {
  final VendorModel vendor;

  const CardRandomWidget({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    List<Widget> card = [
      CircularCard(image: vendor.logo!),
      RectangleCard(image: vendor.logo!),
    ];
    card.shuffle();
    return GestureDetector(
      onTap: () {
        AppRouter.push(
            context,
            VendorDetailsScreen(
              vendor: vendor,
            ));
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 54,
          end: 24,
          bottom: 16,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
              height: 111,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10),
                    bottomEnd: Radius.circular(10),
                    topStart: Radius.circular(50),
                    bottomStart: Radius.circular(50),
                  )),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 48,
                  end: 8,
                  top: 8,
                  bottom: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalixationString(context, vendor.name) ?? "",
                            style: getBoldStyle(
                              color: ColorManager.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              StaticRate(
                                rate: vendor.avgRating,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                    bottomEnd: Radius.circular(20),
                                    topEnd: Radius.circular(20),
                                  ),
                                  color: ColorManager.softYellow,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    double.tryParse(vendor.avgRating ?? '0')!
                                        .toStringAsFixed(1),
                                    style: getBoldStyle(
                                      color: Colors.white,
                                      fontSize: FontSizeApp.s12,
                                    )?.copyWith(
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          InfoCardWithIcon(
                            svgAsset: IconsManager.iconPhone,
                            label: 'العنوان',
                            value: vendor.address,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          InfoCardWithIcon(
                            svgAsset: IconsManager.iconPhone,
                            label: 'رقم الهاتف',
                            value: vendor.phone,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IsOpenLabel(
                          isOpen: vendor.isOpen,
                        ),
                        SvgPicture.asset(
                          IconsManager.iconFavoriteFilled,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned.directional(
              start: -30,
              textDirection: Directionality.of(context),
              child: card[0],
            )
          ],
        ),
      ),
    );
  }
}

class IsOpenLabel extends StatelessWidget {
  const IsOpenLabel({Key? key, required this.isOpen}) : super(key: key);
  final bool? isOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 64,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isOpen == true ? ColorManager.darkRed : null,
          border: Border.all(
            color: ColorManager.darkRed,
          )),
      child: Center(
          child: Text(
        isOpen == true ? 'مفتوح' : 'مغلق',
        style: getBoldStyle(
          color: isOpen == true ? Colors.white : ColorManager.darkRed,
          fontSize: FontSizeApp.s8,
        ),
      )),
    );
  }
}

class InfoCardWithIcon extends StatelessWidget {
  const InfoCardWithIcon(
      {Key? key,
      required this.svgAsset,
      required this.label,
      required this.value})
      : super(key: key);
  final String svgAsset;
  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    if (label == null || value == null) return const SizedBox();
    return Row(
      children: [
        SvgPicture.asset(
          svgAsset,
          height: 14,
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label!,
              style: getBoldStyle(
                color: ColorManager.labelGrey,
                fontSize: 8,
              )?.copyWith(height: 1),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              value!,
              style: getBoldStyle(
                color: ColorManager.shadowGrey,
                fontSize: 10,
              )?.copyWith(height: 1),
            ),
          ],
        )
      ],
    );
  }
}

class StaticRate extends StatelessWidget {
  const StaticRate({Key? key, required this.rate}) : super(key: key);
  final String? rate;

  @override
  Widget build(BuildContext context) {
    double? rating = double.tryParse(rate ?? '0');
    rating ??= 0;
    bool isInteger = (rating % 1) == 0;
    return Row(
      children: [
        for (int index = 1; index <= 5; index++) ...[
          if (!isInteger && index == rating.ceil())
            const Icon(
              Icons.star_half_rounded,
              color: ColorManager.softYellow,
              size: 14,
            )
          else
            Icon(
              rating.toInt() >= index
                  ? Icons.star_rate_rounded
                  : Icons.star_border_rounded,
              color: ColorManager.softYellow,
              size: 14,
            ),
        ],
      ],
    );
  }
}

class CircularCard extends StatelessWidget {
  final String image;

  const CircularCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: ColorManager.boxShadow,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedImage(
            width: 70,
            height: 70,
            imageUrl: image,
          )),
    );
  }
}

class RectangleCard extends StatelessWidget {
  final String image;

  const RectangleCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        boxShadow: ColorManager.boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedImage(
          width: 70,
          height: 70,
          imageUrl: image,
        ),
      ),
    );
  }
}

// class RectangleRotationCard extends StatelessWidget {
//   final String image;
//
//   const RectangleRotationCard({super.key, required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         RotationTransition(
//             turns: new AlwaysStoppedAnimation(40 / 360),
//             child: Container(
//               width: 70,
//               height: 70,
//               transform: new Matrix4.translationValues(
//                   MediaQuery.of(context).size.width * 0.55, -250.0, 0.0)
//                 ..rotateZ(28 * 3.1415927 / 180),
//               decoration: BoxDecoration(
//                 color: Colors.redAccent,
//                 borderRadius: BorderRadius.circular(10),
//                 shape: BoxShape.rectangle,
//                 boxShadow: ColorManager.boxShadow,
//               ),
//               child: RotationTransition(
//                 turns: new AlwaysStoppedAnimation(320 / 360),
//                 child: CachedImage(
//                   imageUrl: image,
//                   height: 70,
//                   width: 70,
//                 ),
//               ),
//             )),
//
//         // ),
//       ],
//     );
//   }
// }

// class RPSCustomPainter extends CustomPainter{
//
//   @override
//   void paint(Canvas canvas, Size size) {
//
//
//
//     Paint paint0 = Paint()
//       ..color = const Color.fromARGB(255, 255, 255, 255)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1.0;
//
//
//     Path path0 = Path();
//     path0.moveTo(size.width*0.0400000,size.height*0.2550000);
//     path0.cubicTo(size.width*0.0400000,size.height*0.6262500,size.width*0.0400000,size.height*0.6262500,size.width*0.0400000,size.height*0.7500000);
//     path0.cubicTo(size.width*0.0287500,size.height*1.0175000,size.width*0.2062500,size.height*1.0075000,size.width*0.2950000,size.height);
//     path0.cubicTo(size.width*0.4575000,size.height*0.9387500,size.width*0.7425000,size.height*0.7362500,size.width*0.8450000,size.height*0.6550000);
//     path0.cubicTo(size.width*0.9462500,size.height*0.5900000,size.width*1.1387500,size.height*0.5100000,size.width*0.8500000,size.height*0.3550000);
//     path0.cubicTo(size.width*0.7287500,size.height*0.2587500,size.width*0.4762500,size.height*0.0762500,size.width*0.3050000,size.height*0.0100000);
//     path0.cubicTo(size.width*0.1787500,size.height*0.0012500,size.width*0.0237500,size.height*-0.0337500,size.width*0.0400000,size.height*0.2550000);
//     path0.close();
//
//     canvas.drawPath(path0, paint0);
//
//
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
//
// }
