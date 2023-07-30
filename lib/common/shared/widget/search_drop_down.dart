import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/utils/styles.dart';

class DropDownSearchApp<T> extends StatefulWidget {
  final void Function(T?)? onChanged;
  final String hintText;
  final bool enabled;
  final VDropdownSearchController vDropdownSearchController;
  final bool withSearch;
  final List<T>? items;
  final String Function(T)? itemAsString;
  final T? selectedItem;
  final bool Function(T, String)? filterFn;
  final String? Function(T?)? validator;
  final String? hintSearchWidget;
  final Widget Function(BuildContext, T, bool)? itemBuilder;

  const DropDownSearchApp({
    required this.items,
    required this.hintText,
    required this.vDropdownSearchController,
    this.itemBuilder,
    this.hintSearchWidget,
    this.validator,
    this.enabled = true,
    this.withSearch = true,
    this.onChanged,
    this.itemAsString,
    this.selectedItem,
    this.filterFn,
    Key? key,
  }) : super(key: key);

  @override
  State<DropDownSearchApp<T>> createState() => _DropDownSearchAppState<T>();
}

class _DropDownSearchAppState<T> extends State<DropDownSearchApp<T>> {
  @override
  Widget build(BuildContext context) {
    widget.vDropdownSearchController._selectedItem ??= widget.selectedItem;
    final borderColorByDefault = borderColor.withOpacity(0.5);
    final borderRadius = BorderRadius.all(
      Radius.circular(30.r),
    );
    return DropdownSearch<T>(
      onChanged: (item) {
        widget.vDropdownSearchController._selectedItem = item;
        setState(() {});
        widget.onChanged?.call(item);
      },
      popupProps: PopupProps.menu(
        isFilterOnline: true,
        menuProps: MenuProps(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
        searchDelay: Duration.zero,
        scrollbarProps: ScrollbarProps(
          thumbColor: primaryColor,
          radius: Radius.circular(20.r),
        ),
        showSearchBox: widget.withSearch,
        fit: FlexFit.loose,
        searchFieldProps: TextFieldProps(
          scrollPadding: EdgeInsets.zero,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: const Icon(
              Icons.search,
              color: darkBorderColor,
              size: 25,
            ),
            hintText: widget.hintSearchWidget,
            hintStyle: Style.commonTextStyle(
              color: hintColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: primaryColor,
              ),
              borderRadius: borderRadius,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColorByDefault,
                width: 1.w,
              ),
              borderRadius: borderRadius,
            ),
          ),
        ),
        //
      ),
      dropdownButtonProps: DropdownButtonProps(
        icon: Icon(
          Icons.arrow_drop_down_outlined,
          color: widget.vDropdownSearchController._selectedItem == null
              ? Colors.grey
              : blackColor,
        ),
        color: widget.enabled ? blackColor : redColor,
      ),
      enabled: widget.enabled,
      filterFn: widget.filterFn,
      items: widget.items ?? [],
      itemAsString: widget.itemAsString,
      selectedItem: widget.selectedItem,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyle(
          fontSize: 14.sp,
          color: blackColor,
          fontWeight: FontWeight.w500,
        ),
        dropdownSearchDecoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          border: InputBorder.none,
          fillColor: whiteColor,
          filled: true,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: redColor),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: grayBorderColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: grayBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: grayBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: grayBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            ),
          ),
        ),
      ),
    );
  }
}

class VDropdownSearchController<T> {
  T? _selectedItem;
  String? _errorMessage;

  VoidCallback? _setState;

  set selectedItem(T? selectedItem) {
    _selectedItem = selectedItem;
    _setState?.call();
  }

  T? get selectedItem {
    return _selectedItem;
  }

  void setError(String? Function(T? selectedItem) isValid) {
    _errorMessage = isValid(selectedItem);
    _setState?.call();
  }
}
