
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerReels extends StatelessWidget {
  const ShimmerReels({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: const Color(0xFFd3d7de),
                highlightColor: const Color(0xFFe2e4e9),
                child: Card(
                  elevation: 0.0,
                  color: const Color.fromRGBO(45, 45, 45, 1.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: const Color(0xFFd3d7de),
                highlightColor: const Color(0xFFe2e4e9),
                child: const Card(
                  elevation: 0.0,
                  color: Color.fromRGBO(45, 45, 45, 1.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SizedBox(
                    width: 200,
                    height: 10,
                  ),
                ),
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: const Color(0xFFd3d7de),
            highlightColor: const Color(0xFFe2e4e9),
            child: const Card(
              elevation: 0.0,
              color: Color.fromRGBO(45, 45, 45, 1.0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SizedBox(
                width: 150,
                height: 10,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: const Color(0xFFd3d7de),
            highlightColor: const Color(0xFFe2e4e9),
            child: const Card(
              elevation: 0.0,
              color: Color.fromRGBO(45, 45, 45, 1.0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SizedBox(
                width: 300,
                height: 10,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
