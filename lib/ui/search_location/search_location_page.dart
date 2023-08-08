import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/ui/search_location/index.dart';
import 'package:pif_flutter/ui/search_location/widget/floor_space_filter.dart';

class SearchLocationPage extends ConsumerWidget {
  const SearchLocationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        bgColor: lightGrayBgColor,
        titleWidget: SearchTextField(
          textEditingController: TextEditingController(),
          onChanged: (value) {},
          hintText: S.current.searchLocation,
          hintTextStyle: Style.commonTextStyle(
            color: hintColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          fillColor: whiteColor,
          showBorders: false,
        ),
      ),
      body: BackgroundWidget(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Assets.searchLocation,
              ).toCenter(),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Enable Smart Discovery for nearby spaces',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: primaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ).toCenter(),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Select Current Location',
                style: Style.commonTextStyle(
                  color: textColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              const FloorSpaceFilter(),
              SizedBox(
                height: 16.h,
              ),
              const SearchLocationListView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 141.h,
        padding:
            EdgeInsets.only(right: 16.w, left: 16.w, top: 35.h, bottom: 58.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: textColor.withOpacity(0.10),
              offset: const Offset(0, -6),
              blurRadius: 14,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            fixedSize: Size(context.screenWidth, 48.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            textStyle: Style.commonTextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          child: Text(
            S.of(context).save,
          ),
        ),
      ),
    );
  }
}
