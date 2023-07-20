import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/services/model/service_model.dart';
import 'package:pif_flutter/ui/services/states/service_state.dart';

final serviceProvider = StateNotifierProvider.autoDispose<ServiceNotifier, ServiceState>((ref) {
  return ServiceNotifier(ref: ref);
});

class ServiceNotifier extends StateNotifier<ServiceState> {
  ServiceNotifier({required this.ref}) : super(ServiceState.initial()) {
    _initData();
  }

  final Ref ref;

  final lstCategory = <CategoryModel>[];
  final lstService = <ServiceModel>[];

  void _initData() {
    bindCategory();
    bindService();

    state = state.copyWith(lstCategory: lstCategory, lstService: lstService);
    state = state.copyWith(isFundamental: true, isCreative: true, isCanceled: true);
  }

  void updateCategory(int id) {
    lstCategory.where((element) => element.isSelected = false).toList();
    final model = lstCategory.firstWhere((element) => element.categoryId == id);
    model.isSelected = true;
    if (model.categoryName == 'All') {
      state = state.copyWith(isFundamental: true, isCreative: true, isCanceled: true);
    } else if (model.categoryName == 'Creative') {
      state = state.copyWith(isCreative: true, isCanceled: false, isFundamental: false);
    } else if (model.categoryName == 'Foundational') {
      state = state.copyWith(isFundamental: true, isCanceled: false, isCreative: false);
    } else if (model.categoryName == 'Canceled') {
      state = state.copyWith(isCanceled: true, isCreative: false, isFundamental: false);
    }
    state = state.copyWith(lstCategory: lstCategory);
  }

  void bindService() {
    lstService.add(
      ServiceModel(
        text: 'QR Booking',
        image: Assets.qrBookingGif,
        onTap: () {},
      ),
    );
    lstService.add(
      ServiceModel(
        text: 'Design',
        image: Assets.designGif,
        onTap: () {},
      ),
    );
    lstService.add(
      ServiceModel(
        text: 'Add Visitors',
        image: Assets.addVisitorGif,
        onTap: () {},
      ),
    );
    lstService.add(
      ServiceModel(
        text: 'Booking',
        image: Assets.bookingGif,
        onTap: () {},
      ),
    );
    lstService.add(
      ServiceModel(
        text: 'Add Visitors',
        image: Assets.addVisitorGif,
        onTap: () {},
      ),
    );
    lstService.add(
      ServiceModel(
        text: 'IT support',
        image: Assets.supportGif,
        onTap: () {},
      ),
    );
    lstService.add(
      ServiceModel(
        text: 'Logistics',
        image: Assets.logisticsGif,
        onTap: () {},
      ),
    );
    lstService.add(
      ServiceModel(
        text: 'Marketing',
        image: Assets.marketingGif,
        onTap: () {},
      ),
    );
  }

  void bindCategory() {
    lstCategory.add(CategoryModel(isSelected: true, categoryId: 0, categoryName: 'All'));
    lstCategory.add(CategoryModel(isSelected: false, categoryId: 1, categoryName: 'Creative'));
    lstCategory.add(CategoryModel(isSelected: false, categoryId: 2, categoryName: 'Foundational'));
    lstCategory.add(CategoryModel(isSelected: false, categoryId: 3, categoryName: 'Canceled'));
  }
}
