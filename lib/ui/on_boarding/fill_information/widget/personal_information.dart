import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/common_dropdown_search.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';

class PersonalInformation extends ConsumerWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(fillInformationProvider.notifier);
    final provider = ref.watch(fillInformationProvider);

    return Column(
      children: [
        SizedBox(height: 20.h),
        CommonDropDownSearchWidget(
          selectedValue: provider.selectedNationality,
          placeholder: S.current.nationality,
          data: provider.nationalList.value!,
          onItemSelected: notifier.updateNationality,
        ),
        SizedBox(height: 10.h),
        if (provider.selectedNationality != null &&
            provider.selectedNationality?.title != 'Saudi Arabic') ...[
          CommonDropDownSearchWidget(
            selectedValue: provider.selectedType,
            placeholder: S.current.idType,
            data: notifier.lstTypes,
            onItemSelected: notifier.updateType,
          ),
          SizedBox(height: 10.h),
        ],
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
