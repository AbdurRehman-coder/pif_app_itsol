import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/dashboard/model/actions_model.dart';
import 'package:pif_flutter/ui/dashboard/state/dashboard_state.dart';
import 'package:pif_flutter/ui/drinks/provider/drinks_provider.dart';

final dashboardProvider =
    StateNotifierProvider.autoDispose<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(ref: ref);
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier({required this.ref}) : super(DashboardState.initial()) {
    _initData();
  }

  final Ref ref;
  List<String> actionIcon = [
    'http://20.74.136.229/o/commerce-media/accounts/-1/images/150636?download=false',
    'http://20.74.136.229/o/commerce-media/accounts/-1/images/172513?download=false',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYDx30d_lWfWk8kJDjv34aVDEO3bwxb-q0fe5hav4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYDx30d_lWfWk8kJDjv34aVDEO3bwxb-q0fe5hav4&s',
  ];

  void _initData() {
    final actions = List.generate(
      actionIcon.length,
      (index) => ActionModel(
        actionImage: actionIcon[index],
        actionFunction: () {
          if(index==0){
           // ref.read(drinksProvider.notifier).orderNow(context: );
          }
        },
      ),
    ).toList();
    state = state.copyWith(
      actionList: AsyncData(actions),
    );
  }
}
