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

class SearchLocationPage extends ConsumerStatefulWidget {
  const SearchLocationPage({super.key});

  @override
  ConsumerState createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends ConsumerState<SearchLocationPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () async {
        await ref.read(searchLocationProvider.notifier).getLocationData();
        ref.read(searchLocationProvider.notifier).getFloor();
        ref.read(searchLocationProvider.notifier).getRoomType();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(searchLocationProvider.notifier);
    final provider = ref.watch(searchLocationProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        bgColor: lightGrayBgColor,
        titleWidget: SearchTextField(
          textEditingController: notifier.searchController,
          onChanged: notifier.searchData,
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
              ).visibility(visible: provider.lstRoomType.isNotEmpty && provider.lstFloor.isNotEmpty),
              SizedBox(
                height: 8.h,
              ).visibility(visible: provider.lstRoomType.isNotEmpty && provider.lstFloor.isNotEmpty),
              FloorSpaceFilter(provider, notifier).visibility(visible: provider.lstRoomType.isNotEmpty && provider.lstFloor.isNotEmpty),
              SizedBox(
                height: 16.h,
              ),
              SearchLocationListView(provider, notifier),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 20.h, bottom: 40.h),
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
          onPressed: notifier.saveAsync,
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
