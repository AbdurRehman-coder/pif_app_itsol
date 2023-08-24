import 'package:collection/collection.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/ui/booking/state/add_visitor_state.dart';

final addVisitorProvider = StateNotifierProvider.autoDispose<AddVisitorNotifier, AddVisitorState>((ref) {
  return AddVisitorNotifier(ref: ref);
});

class AddVisitorNotifier extends StateNotifier<AddVisitorState> {
  AddVisitorNotifier({required this.ref}) : super(AddVisitorState.initial()) {
    _initData();
  }

  final Ref ref;
  late TextEditingController visitorFirstNameController;
  late TextEditingController visitorLastNameController;
  late TextEditingController visitorEmailController;
  late FocusNode firstNameFocus;
  late FocusNode lastNameFocus;
  late FocusNode emailFocus;
  late GlobalKey<FormState> formKey;

  void _initData() {
    visitorFirstNameController = TextEditingController();
    visitorLastNameController = TextEditingController();
    visitorEmailController = TextEditingController();
    formKey = GlobalKey<FormState>();
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    emailFocus = FocusNode();

    firstNameFocus.addListener(() {
      state = state.copyWith(isFocusFirstName: firstNameFocus.hasFocus);
    });
    lastNameFocus.addListener(() {
      state = state.copyWith(isFocusLastName: lastNameFocus.hasFocus);
    });
    emailFocus.addListener(() {
      state = state.copyWith(isFocusEmail: emailFocus.hasFocus);
    });
  }

  void onChangeText(String? text) {}

  // Invite Now Event
  Future<void> inviteAsync({required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      final provider = ref.read(bookingProvider);
      final notifier = ref.read(bookingProvider.notifier);
      final firstName = visitorFirstNameController.text.trim();
      final lastName = visitorLastNameController.text.trim();
      final email = visitorEmailController.text.trim();

      final model = UserModel(
        familyName: firstName,
        givenName: lastName,
        emailAddress: email,
        name: '$firstName $lastName',
      );
      final lstData = provider.lstGuests.toList();
      final userData = await DixelsSDK.instance.userDetails;
      if (userData != null && userData.emailAddress == email) {
        alertMessage(
          errorMessage: S.of(context).userAlreadyExist,
          context: context,
        );
        return;
      }
      final isDataAvailable = lstData.firstWhereOrNull(
        (element) => element.emailAddress == model.emailAddress,
      );
      if (isDataAvailable != null) {
        alertMessage(
          errorMessage: S.current.visitorAlreadyFound,
          context: context,
        );
        return;
      }
      lstData.add(model);

      notifier.updateInviteList(lstData);
      AppRouter.pop();
    }
  }
}
