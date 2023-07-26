import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/ui/search_location/index.dart';

class SearchLocationPage extends ConsumerWidget {
  const SearchLocationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: lightGrayBgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: lightGrayBgColor,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: AppRouter.pop,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: activeBgColor,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 20,
              ),
            ),
          ),
        ),
        title: SearchTextField(
          textEditingController: TextEditingController(),
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: S.current.searchLocation,
            contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 20),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.r),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: darkBorderColor,
              size: 25,
            ),
            filled: true,
            hintStyle: Style.commonTextStyle(
              color: hintColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Padding(
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
              height: 35.h,
            ),
            Text(
              'Select Current Location',
              style: Style.commonTextStyle(
                color: textColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            const SearchLocationListView(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 141.h,
        padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 35.h, bottom: 58.w),
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
            S.of(context).search,
          ),
        ),
      ),
    );
  }
}
