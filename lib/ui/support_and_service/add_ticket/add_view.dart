import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/provider/add_ticket_provider.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/widget/image_selected.dart';

class AddTicketView extends ConsumerStatefulWidget {
  const AddTicketView({
    super.key,
  });

  @override
  ConsumerState createState() => _AddOrEditTicketViewState();
}

class _AddOrEditTicketViewState extends ConsumerState<AddTicketView> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(addOrEditTicketProvider.notifier);
    final provider = ref.watch(addOrEditTicketProvider);
    return Scaffold(
      backgroundColor: expireBgColor,
      appBar: AppBar(
        backgroundColor: expireBgColor,
        elevation: 0,
        // <-- Use this
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: InkWell(
            onTap: AppRouter.pop,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 25,
              ),
            ),
          ),
        ),
        title: Text(
          'Get Support',
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            SizedBox(height: 29.h),
            Stack(
              children: [
                CustomTextField(
                  textEditingController: notifier.issueDescriptionController,
                  maxLines: 10,
                  hintText: 'Issue Description',
                  maxLength: 300,
                ),
                Positioned(
                  bottom: 20.h,
                  right: 8.w,
                  child: IconButton(
                    icon: const Icon(
                      Icons.attachment,
                      color: hintColor,
                    ),
                    onPressed: notifier.uploadImage,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            if (provider.image != null) ...[
              ImageSelected(
                imageFile: provider.image!,
              ),
            ],
            SizedBox(height: 10.h),
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(6.r),
                ),
              ),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => const SizedBox(),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Space & Logistics',
                    style: Style.commonTextStyle(
                      color: hintColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10.h),
            ),
            child: Text(
              'Get Support',
              style: Style.commonTextStyle(
                color: whiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
