import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_drop_down.dart';
import 'package:pif_flutter/ui/search_location/provider/search_location_provider.dart';
import 'package:pif_flutter/ui/search_location/states/search_location_state.dart';

class FloorSpaceFilter extends StatelessWidget {
  const FloorSpaceFilter(this.provider, this.notifier, {super.key});

  final SearchLocationState provider;
  final SearchLocationNotifier notifier;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> addDividersAfterItems(
      List<String> items,
    ) {
      final menuItems = <DropdownMenuItem<String>>[];
      for (final item in items) {
        menuItems.addAll(
          [
            DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: provider.selectedFloor == item ? primaryColor : darkTextColor,
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

    List<DropdownMenuItem<String>> addLstSpaceType(
      List<String> items,
    ) {
      final menuItems = <DropdownMenuItem<String>>[];
      for (final item in items) {
        menuItems.addAll(
          [
            DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: provider.selectedSpaceType == item ? primaryColor : darkTextColor,
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

    return Row(
      children: [
        Expanded(
          child: CustomDropDownMenu<String>(
            hintText: S.current.floor,
            items: provider.lstFloor,
            onChanged: (data) {
              notifier.updateSelectedFloor(floor: data ?? '');
              notifier.filterSpaceData();
            },
            selectedValue: provider.selectedFloor,
            dropDownMenuItemList: addDividersAfterItems(provider.lstFloor),
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: CustomDropDownMenu<String>(
            hintText: S.current.spaceType,
            items: provider.lstRoomType,
            onChanged: (data) {
              notifier.updateSelectedRoomType(roomType: data ?? '');
              notifier.filterSpaceData();
            },
            selectedValue: provider.selectedSpaceType,
            dropDownMenuItemList: addLstSpaceType(provider.lstRoomType),
          ),
        ),
      ],
    );
  }
}
