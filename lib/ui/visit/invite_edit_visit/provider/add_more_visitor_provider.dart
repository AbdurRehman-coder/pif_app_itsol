import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/model/invite_edit_visit_model.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/provider/invite_edit_visit_provider.dart';

final addMoreVisitorProvider =
    Provider.autoDispose<AddMoreVisitorNotifier>((ref) {
  return AddMoreVisitorNotifier(ref: ref);
});

class AddMoreVisitorNotifier {
  AddMoreVisitorNotifier({required this.ref}) {
    _initData();
  }

  final Ref ref;

  late GlobalKey<FormState> formKey;
  FocusNode emailFocus = FocusNode();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  void _initData() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();

    formKey = GlobalKey<FormState>();
  }

  void addVisitor({required BuildContext context}) {
    if (formKey.currentState!.validate()) {
      final itemModel = InviteVisitorModel(
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        fromHistory: false,
        isVisitorVerified: false,
      );
      final notifier = ref.read(inviteVisitorProvider.notifier);
      notifier.addVisitorFromAddMoreVisitor(
        context: context,
        item: itemModel,
      );
    }
  }
}
