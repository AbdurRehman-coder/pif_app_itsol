import 'package:dixels_sdk/features/commerce/support/model/ticket_category_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/alert_popup.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/shared/widget/custom_drop_down.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/common/shared/widget/search_drop_down.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/add_ticket_model.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/provider/add_ticket_provider.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/widget/image_selected.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/widget/teams_list.dart';

class AddTicketView extends ConsumerStatefulWidget {
  const AddTicketView({
    required this.addTicketModel,
    super.key,
  });

  final AddTicketModel? addTicketModel;

  @override
  ConsumerState createState() => _AddOrEditTicketViewState();
}

class _AddOrEditTicketViewState extends ConsumerState<AddTicketView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(addOrEditTicketProvider.notifier).getCategoriesAsync(
            addTicketModel: widget.addTicketModel,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(addOrEditTicketProvider);
    final notifier = ref.read(addOrEditTicketProvider.notifier);
    List<DropdownMenuItem<TicketCategoryModel>> addDividersAfterItems(
      List<TicketCategoryModel> items,
    ) {
      final menuItems = <DropdownMenuItem<TicketCategoryModel>>[];
      for (final item in items) {
        menuItems.addAll(
          [
            DropdownMenuItem<TicketCategoryModel>(
              value: item,
              child: Text(
                item.name ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: provider.selectedSubCategory == item
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
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: S.current.getSupport,
        onClickBack: () => alertPopup(
          context: context,
          deleteMessage: S.current.discardTheTicket,
          onClickYes: () => widget.addTicketModel != null
              ? AppRouter.popUntil(Routes.dashboardScreen)
              : AppRouter.popUntil(Routes.myTicketsScreen),
        ),
      ),
      body: BackgroundWidget(
        child: WillPopScope(
          onWillPop: () async {
            await alertPopup(
              context: context,
              deleteMessage: S.current.discardTheTicket,
              onClickYes: () => widget.addTicketModel != null
                  ? AppRouter.popUntil(Routes.dashboardScreen)
                  : AppRouter.popUntil(Routes.myTicketsScreen),
            );
            return true;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              left: 18.w,
              right: 18.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomTextField(
                      keyboardType: TextInputType.multiline,
                      textEditingController:
                          notifier.issueDescriptionController,
                      maxLines: 9,
                      hintText: S.current.issueDescription,
                      maxLength: 300,
                      style: Style.commonTextStyle(
                        color: dayTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (provider.image == null) ...[
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
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
                SizedBox(height: 5.h),
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
                  SizedBox(
                    height: 15.h,
                  ),
                ],
                if (provider.image != null) ...[
                  ImageSelected(
                    imageFile: provider.image!,
                    onDeleteFile: notifier.onDeleteFile,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
                TeamsList(
                  notifier: notifier,
                  provider: provider,
                ),
                SizedBox(height: 15.h),
/*
                if (provider.selectedCategory != null) ...[
                  CustomDropDownMenu<TicketCategoryModel>(
                    hintText: S.current.subCategory,
                    items: provider.lstSubCategory,
                    onChanged: (data) => notifier.updateSubCategory(
                      item: data!,
                    ),
                    selectedValue: provider.selectedSubCategory,
                    dropDownMenuItemList:
                        addDividersAfterItems(provider.lstSubCategory),
                  ),

                ],
*/
                if (provider.selectedCategory != null) ...[
                  DropDownSearchApp<TicketCategoryModel>(
                    withSearch: false,
                    selectedItem: provider.selectedSubCategory,
                    hintText: S.current.subCategory,
                    onChanged: (data) => notifier.updateSubCategory(
                      item: data!,
                    ),
                    items: provider.lstSubCategory,
                    itemAsString: (item) {
                      return item.name ?? '';
                    },
                    vDropdownSearchController: VDropdownSearchController(),
                  ),
                  SizedBox(height: 200.h),
                ],
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        color: expireBgColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => notifier.createTicketAsync(
                  context: context,
                  addTicketModel: widget.addTicketModel,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
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
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
