import 'package:dixels_sdk/features/commerce/booking/model/deliver_space_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/search_location/provider/search_location_provider.dart';
import 'package:pif_flutter/ui/search_location/states/search_location_state.dart';
import 'package:pif_flutter/ui/search_location/widget/search_location_item_view.dart';

class SearchLocationDataView extends StatelessWidget {
  const SearchLocationDataView({
    required this.data,
    required this.provider,
    required this.notifier,
    super.key,
  });
  final List<DeliverySpaceModel> data;
  final SearchLocationState provider;
  final SearchLocationNotifier notifier;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20.h),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            notifier.updateLocationSelected(index);
          },
          child: SearchLocationItemView(
            data: data[index],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8.h,
        );
      },
      itemCount: data.length,
    );
  }
}
