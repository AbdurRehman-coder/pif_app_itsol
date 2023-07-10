import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/state/add_ticket_state.dart';

final addOrEditTicketProvider = StateNotifierProvider.autoDispose<
    AddOrEditTicketNotifier, AddOrEditTicketState>((ref) {
  return AddOrEditTicketNotifier(ref: ref);
});

class AddOrEditTicketNotifier extends StateNotifier<AddOrEditTicketState> {
  AddOrEditTicketNotifier({required this.ref})
      : super(AddOrEditTicketState.initial());
  final issueDescriptionController = TextEditingController();
  final Ref ref;
  final picker = ImagePicker();

  Future<void> uploadImage() async {
    final imageSelected = await picker.pickImage(source:ImageSource.gallery);
    if (imageSelected != null) {
      state = state.copyWith(image: imageSelected);
    }
  }
}
