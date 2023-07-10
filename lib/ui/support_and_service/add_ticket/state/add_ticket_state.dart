import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'add_ticket_state.freezed.dart';

@freezed
class AddOrEditTicketState with _$AddOrEditTicketState {
  const factory AddOrEditTicketState({
    required XFile? image,
  }) = _AddOrEditTicketState;

  factory AddOrEditTicketState.initial() => const AddOrEditTicketState(
    image: null,
  );
}
