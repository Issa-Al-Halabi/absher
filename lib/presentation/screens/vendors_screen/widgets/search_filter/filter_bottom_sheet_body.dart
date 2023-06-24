import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/filter_button.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/filter_by_star_bottom_sheet_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/custom_button.dart';

class FilterBottomSheetBody extends StatelessWidget {
  FilterBottomSheetBody({Key? key}) : super(key: key);
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    VendorsListBloc vendorsListBloc = context.read<VendorsListBloc>();
    return BlocBuilder<VendorsListBloc, VendorsListState>(
        builder: (context, state) {
      if (state.screenStates == ScreenStates.success) {
        return SizedBox(
          height: 400,
          child: PageView.builder(
            controller: pageController,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              switch (index) {
                case 1:
                  return FilterByStarsBottomSheetBody(
                    pageController: pageController,
                  );
              }
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Filter By',
                          style: getBoldStyle(color: ColorManager.primaryColor),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            vendorsListBloc.add(ClearFilterValues());
                          },
                          child: const Icon(
                            Icons.filter_alt_off_outlined,
                            color: ColorManager.primaryColor,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(1);
                      },
                      child: Container(
                        width: 1.sw,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "By_Rate",
                                  style:
                                      vendorsListBloc.pendingFilter.rate != null
                                          ? getBoldStyle(
                                              color: ColorManager.primaryColor)
                                          : getBoldStyle(
                                              color: ColorManager.primaryColor),
                                ),
                                if (vendorsListBloc.pendingFilter.rate != null)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: ColorManager.softYellow,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: state.pendingFilters.rate! >= 2
                                            ? ColorManager.softYellow
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: state.pendingFilters.rate! >= 3
                                            ? ColorManager.softYellow
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: state.pendingFilters.rate! >= 4
                                            ? ColorManager.softYellow
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: state.pendingFilters.rate! >= 5
                                            ? ColorManager.softYellow
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                    ],
                                  )
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    FilterButton(
                      label: 'Near_By',
                      isSelected: state.pendingFilters.lon != null,
                      onTab: () {
                        vendorsListBloc.add(ToggleNearByFilter());
                      },
                    ),
                    FilterButton(
                      label: 'Opening Now',
                      isSelected: state.pendingFilters.isOpen == true,
                      onTab: () {
                        vendorsListBloc.add(ToggleIsOpenFilter());
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        fillColor: ColorManager.softYellow,
                        label: 'Apply',
                        onTap: () {
                          Navigator.of(context).pop();
                          vendorsListBloc.add(SetAppliedFilter());
                          vendorsListBloc.add(RefreshVendorsList());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 64),
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50), // Set the border radius to 50 to make it circular
                            ),
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: ColorManager.primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Dismiss',
                                  style: getBoldStyle(
                                      color: ColorManager.primaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              // Return different screens based on index
            },
          ),
        );
      }
      return const SizedBox();
    });
  }
}
