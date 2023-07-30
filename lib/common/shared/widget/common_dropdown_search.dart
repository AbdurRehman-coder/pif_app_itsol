import 'package:dixels_sdk/features/users/country/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/model/nationality_model.dart';

class CommonDropDownSearchWidget extends StatefulWidget {
  const CommonDropDownSearchWidget({
    required this.data,
    super.key,
    this.placeholder = '',
    this.selectedValue,
    this.onItemSelected,
    this.onClickOnDropDown,
    this.isEnable = true,
    this.withSearch = false,
    this.searchPlaceholder = 'Search',
  });

  final List<CountryModel> data;
  final String placeholder;
  final String searchPlaceholder;
  final bool isEnable;
  final bool withSearch;
  final CountryModel? selectedValue;
  final void Function(CountryModel)? onItemSelected;
  final void Function(bool)? onClickOnDropDown;

  @override
  State<CommonDropDownSearchWidget> createState() =>
      _CommonDropDownSearchWidgetState();
}

class _CommonDropDownSearchWidgetState
    extends State<CommonDropDownSearchWidget> {
  bool isOpen = false;
  final searchController = TextEditingController();
  List<CountryModel> filterData = <CountryModel>[];

  @override
  void initState() {
    super.initState();
    filterData = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            if (widget.isEnable) {
              setState(() {
                FocusManager.instance.primaryFocus?.unfocus();
                isOpen = !isOpen;
              });
              widget.onClickOnDropDown?.call(isOpen);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: grayBorderColor),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.selectedValue == null
                        ? widget.placeholder
                        : widget.selectedValue?.title_i18n?.en_US ?? '',
                    style: Style.commonTextStyle(
                      color:
                          widget.selectedValue == null ? hintColor : textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 24.w,
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 7.h),
          height: widget.data.length > 5
              ? 300.h
              : (widget.data.length * 15.h) + 80.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: grayBorderColor),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              if (widget.withSearch) ...[
                SearchTextField(
                  textEditingController: searchController,
                  hintText: widget.searchPlaceholder,
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        final data = widget.data
                            .where(
                              (element) => element.title_i18n!.en_US!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()),
                            )
                            .toList();
                        filterData = data;
                      } else {
                        filterData = widget.data;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  itemCount: filterData.length,
                  physics: filterData.length > 5 // maintain code format
                      ? const AlwaysScrollableScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          isOpen = false;
                        });
                        widget.onClickOnDropDown?.call(isOpen);
                        final item = filterData[index];
                        widget.onItemSelected?.call(item);
                        searchController.text = '';
                        filterData = widget.data;
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        child: Expanded(
                          child: Text(
                            '${filterData[index]
                                    .a2!
                                    .toUpperCase()
                                    .replaceAllMapped(
                                      RegExp(r'[A-Z]'),
                                      (match) => String.fromCharCode(
                                        (match.group(0)?.codeUnitAt(0))! +
                                            127397,
                                      ),
                                    )} ${filterData[index].title_i18n?.en_US ?? ''}',
                            style: Style.commonTextStyle(
                              color: textColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(thickness: 1.h);
                  },
                ).visibility(visible: isOpen),
              ),
            ],
          ),
        ).visibility(visible: isOpen),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
