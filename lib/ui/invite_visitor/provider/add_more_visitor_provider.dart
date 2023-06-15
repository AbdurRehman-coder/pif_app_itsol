import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/invite_visitor/index.dart';

final addMoreVisitorProvider = Provider.autoDispose<AddMoreVisitorNotifier>((ref) {
  return AddMoreVisitorNotifier(ref: ref);
});

class AddMoreVisitorNotifier {
  AddMoreVisitorNotifier({required this.ref}) {
    _initData();
  }

  final Ref ref;

  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  void _initData() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  void addVisitor() {
    if (formKey.currentState!.validate()) {
      final itemModel = InviteVisitorModel(
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        '',
        false,
      );

      final notifier = ref.read(inviteVisitorProvider.notifier);
      notifier.addVisitor(itemModel);
      AppRouter.pop();
    }
  }
}
