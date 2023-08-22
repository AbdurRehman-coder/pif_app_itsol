import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class DropDownSearchApp<T> extends StatefulWidget {
  DropDownSearchApp({
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
    this.fit = FlexFit.loose,
    this.dropDownBorderRadius = const BorderRadius.all(
      Radius.circular(15),
    ),
    super.key,
  });

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
  BorderRadius dropDownBorderRadius;
  FlexFit fit;

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
    return Stack(
      children: [
        DropdownSearch<T>(
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
            fit: widget.fit,
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
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: grayA0,
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
            textAlignVertical:
                widget.vDropdownSearchController._selectedItem != null ? TextAlignVertical.bottom : null,
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
              contentPadding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                bottom: 8.h,
              ),
              border: InputBorder.none,
              fillColor: whiteColor,
              filled: true,
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: redColor),
                borderRadius: widget.dropDownBorderRadius,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: grayBorderColor,
                ),
                borderRadius: widget.dropDownBorderRadius,
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: grayBorderColor),
                borderRadius: widget.dropDownBorderRadius,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: grayBorderColor),
                borderRadius: widget.dropDownBorderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: grayBorderColor),
                borderRadius: widget.dropDownBorderRadius,
              ),
            ),
          ),
        ),
        if (widget.vDropdownSearchController._selectedItem != null) ...[
          Positioned(
            top: 3.h,
            left: 10.w,
            child: Text(
              widget.hintText ?? '',
              style: Style.commonTextStyle(
                color: hintColor,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
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
