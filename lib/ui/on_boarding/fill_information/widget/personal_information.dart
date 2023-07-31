import 'package:dixels_sdk/features/users/country/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/search_drop_down.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/model/nationality_model.dart';
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
        if (!provider.countryList.isLoading) ...[
          DropDownSearchApp<CountryModel>(
            items: provider.countryList.value ?? [],
            hintText: S.current.nationality,
            hintSearchWidget: S.current.search,
            selectedItem: provider.selectedNationality,
            onChanged: (country) => notifier.updateCountry(country!),
            vDropdownSearchController: VDropdownSearchController(),
            itemAsString: (val) {
              return '${val.a2!.toUpperCase().replaceAllMapped(
                    RegExp(r'[A-Z]'),
                    (match) => String.fromCharCode(
                      (match.group(0)?.codeUnitAt(0))! + 127397,
                    ),
                  )} ${val.title_i18n?.en_US ?? ''}';
            },
          ),
        ],
        SizedBox(height: 10.h),
        if (provider.selectedNationality != null &&
            provider.selectedNationality?.a2 != 'SA') ...[
          DropDownSearchApp<TypeModel>(
            items: provider.typeList.value,
            hintText: S.current.idType,
            selectedItem: provider.selectedType,
            withSearch: false,
            vDropdownSearchController: VDropdownSearchController(),
            onChanged: (type) => notifier.updateIDType(typeSelected: type!),
            itemAsString: (val) {
              return val.title;
            },
          ),
          SizedBox(height: 10.h),
        ],
        SecondCustomTextField(
          onTap: notifier.scrollToIndex,
          focusNode: notifier.idNumberFocusNode,
          textEditingController: notifier.iDController,
          hintText: S.current.idNumber,
          maxLength: provider.selectedNationality?.a2 == 'SA' ||
                  provider.selectedType?.id == '2'
              ? 10
              : null,
          fillColor: whiteColor,
          onChanged: (val) => notifier.update(),
        ),
      ],
    );
  }
}
