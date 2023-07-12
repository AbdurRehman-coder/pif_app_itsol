import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/alert_popup.dart';
import 'package:pif_flutter/common/shared/widget/custom_drop_down.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/subcategory_model.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/provider/add_ticket_provider.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/widget/image_selected.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/widget/teams_list.dart';

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
    List<DropdownMenuItem<SubCategoryModel>> addDividersAfterItems(
      List<SubCategoryModel> items,
    ) {
      final menuItems = <DropdownMenuItem<SubCategoryModel>>[];
      for (final item in items) {
        menuItems.addAll(
          [
            DropdownMenuItem<SubCategoryModel>(
              value: item,
              child: Text(
                item.subcategoryText,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: provider.subcategorySelected == item
                      ? primaryColor
                      : darkTextColor,
                ),
              ),
            ),
            if (item != items.last)
              const DropdownMenuItem(
                enabled: false,
                child: Divider(
                  thickness: 1.3,
                ),
              ),
          ],
        );
      }
      return menuItems;
    }

    return Scaffold(
      backgroundColor: expireBgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: expireBgColor,
        elevation: 0,
        // <-- Use this
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: InkWell(
            onTap: () => alertPopup(
              context: context,
              deleteMessage: S.current.discardTheTicket,
              onClickYes: () => AppRouter.popUntil(Routes.myTicketsScreen),
            ),
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
          S.current.getSupport,
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        titleSpacing: 0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          await alertPopup(
            context: context,
            deleteMessage: S.current.discardTheTicket,
            onClickYes: () => AppRouter.popUntil(Routes.myTicketsScreen),
          );
          return true;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 29.h),
                Stack(
                  children: [
                    CustomTextField(
                      keyboardType: TextInputType.multiline,
                      textEditingController:
                          notifier.issueDescriptionController,
                      maxLines: 10,
                      hintText: S.current.issueDescription,
                      maxLength: 300,
                    ),
                    if (provider.image == null) ...[
                      Positioned(
                        bottom: 20.h,
                        right: 8.w,
                        child: IconButton(
                          icon: const Icon(
                            Icons.image_outlined,
                            color: hintColor,
                          ),
                          onPressed: notifier.uploadImage,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 24.h),
                if (provider.loadImage) ...[
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: gray98.withOpacity(0.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: gray85,
                    ),
                  ),
                ],
                if (provider.image != null) ...[
                  ImageSelected(
                    imageFile: provider.image!,
                    onDeleteFile: notifier.onDeleteFile,
                  ),
                ],
                SizedBox(height: 10.h),
                const TeamsList(),
                SizedBox(height: 15.h),
                if (provider.isTeamSelected) ...[
                  CustomDropDownMenu<SubCategoryModel>(
                    hintText: S.current.subCategory,
                    items: provider.subCategoryList.value ?? [],
                    onChanged: (subCategory) => notifier.updateSubCategory(
                      subcategorySelected: subCategory!,
                    ),
                    selectedValue: provider.subcategorySelected,
                    dropDownMenuItemList:
                        addDividersAfterItems(provider.subCategoryList.value!),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => notifier.createTicket(context: context),
            style: ElevatedButton.styleFrom(
              backgroundColor: notifier.issueDescriptionController.text.isEmpty
                  ? primaryDisabledColor
                  : primaryColor,
              padding: EdgeInsets.symmetric(vertical: 10.h),
            ),
            child: Text(
              S.current.getSupport,
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
