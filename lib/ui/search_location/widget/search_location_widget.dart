import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/search_location/provider/search_location_provider.dart';
import 'package:pif_flutter/ui/search_location/states/search_location_state.dart';
import 'package:pif_flutter/ui/search_location/widget/search_location_data_view.dart';
import 'package:pif_flutter/ui/search_location/widget/search_location_empty_view.dart';
import 'package:pif_flutter/ui/search_location/widget/search_location_shimmer_widget.dart';

class SearchLocationListView extends StatelessWidget {
  const SearchLocationListView(this.provider, this.notifier, {super.key});
  final SearchLocationState provider;
  final SearchLocationNotifier notifier;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: provider.lstSearchLocation.when(
        data: (data) {
          if (data.isEmpty) {
            return const SearchLocationEmptyView();
          } else {
            return SearchLocationDataView(
              data: data,
              notifier: notifier,
              provider: provider,
            );
          }
        },
        error: (error, stackTrace) {
          return const SearchLocationEmptyView();
        },
        loading: () {
          return const SearchLocationShimmerWidget();
        },
      ),
    );
  }
}
