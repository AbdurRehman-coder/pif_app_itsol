import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_drop_down.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/model/nationality_model.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';

class PersonalInformation extends ConsumerWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(fillInformationProvider.notifier);
    final provider = ref.watch(fillInformationProvider);
    List<DropdownMenuItem<NationalityModel>> addDividersAfterItems(
      List<NationalityModel> items,
    ) {
      final menuItems = <DropdownMenuItem<NationalityModel>>[];
      for (final item in items) {
        menuItems.addAll(
          [
            DropdownMenuItem<NationalityModel>(
              value: item,
              child: Text(
                item.nationalityText,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: provider.nationalitySelect == item
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


    return Column(
      children: [
        SizedBox(height: 20.h),
        CustomDropDownMenu<NationalityModel>(
          hintText: S.current.nationality,
          items: provider.nationalList.value ?? [],
          dropDownMenuItemList: addDividersAfterItems(
            provider.nationalList.value!,
          ),
          selectedValue: provider.nationalitySelect,

        ),
        SizedBox(height: 20.h),
        SecondCustomTextField(
          textEditingController: notifier.nationalController,
          hintText: S.current.idNumber,
          fillColor: whiteColor,
          // onChanged: (val)=>,
        ),
        SizedBox(height: 300.h),
      ],
    );
  }
}
