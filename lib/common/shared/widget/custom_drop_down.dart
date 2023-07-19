import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class CustomDropDownMenu<T> extends StatelessWidget {
  const CustomDropDownMenu({
    required this.hintText,
    required this.items,
    required this.dropDownMenuItemList,
    this.withBottomText = false,
    this.onChanged,
    this.selectedValue,
    super.key,
  });

  final String hintText;
  final List<T> items;
  final List<DropdownMenuItem<T>>? dropDownMenuItemList;
  final void Function(T?)? onChanged;
  final T? selectedValue;
  final bool withBottomText;

  List<double> getCustomItemsHeights() {
    final itemsHeights = <double>[];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(50.h);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(14.h);
      }
    }
    return itemsHeights;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: DropdownButton2<T>(
                  hint: Text(
                    hintText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: hintColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  isExpanded: true,
                  items: dropDownMenuItemList,
                  value: selectedValue,
                  onChanged: onChanged,
                  buttonStyleData: ButtonStyleData(
                    height: 50.h,
                    width: 160.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: grayBorderColor,
                      ),
                      color: whiteColor,
                    ),
                  ),
                  iconStyleData: IconStyleData(
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                    ),
                    iconSize: 25,
                    iconEnabledColor: selectedValue == null ? expireStatusColor : primaryColor,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 180.h,
                    elevation: 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: whiteColor,
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: Radius.circular(10.r),
                      trackColor: MaterialStateProperty.all(primaryColor),
                      trackBorderColor: MaterialStateProperty.all(primaryColor),
                      thumbColor: MaterialStateProperty.all(primaryColor),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    customHeights: getCustomItemsHeights(),
                  ),
                ),
              ),
              if (selectedValue != null) ...[
                Positioned(
                  top: 2.h,
                  left: 10.w,
                  child: Text(
                    hintText,
                    style: Style.commonTextStyle(
                      fontSize: 10.sp,
                      color: hintColor,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
        if(withBottomText)...[
          Text(
            S.current.selectItem,
            style: Style.commonTextStyle(
              color: expireStatusColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
