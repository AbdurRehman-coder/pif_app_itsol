import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/model/tiicket_model.dart';
import 'package:pif_flutter/ui/support_and_service/ticket_details/index.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

final ticketDetailsProvider =
    StateNotifierProvider.autoDispose<TicketDetailsNotifier, TicketDetailsState>((ref) {
  return TicketDetailsNotifier(ref: ref);
});

class TicketDetailsNotifier extends StateNotifier<TicketDetailsState> {
  TicketDetailsNotifier({required this.ref}) : super(TicketDetailsState.initial()) {
    _initData();
  }

  final Ref ref;
  TicketModel? ticketData;
  late AutoScrollController scrollController;
  late TextEditingController commentController;
  late FocusNode commentFocusNode;
  int durationMilliseconds = 400;
  final picker = ImagePicker();

  void _initData() {
    scrollController = AutoScrollController();
    commentController = TextEditingController();
    commentFocusNode = FocusNode();
    bindCommentData();

    commentFocusNode.addListener(onFocusChange);
  }

  void onFocusChange() {
    if (commentFocusNode.hasFocus) {
      scrollToEnd();
    }
  }

  void bindCommentData() {
    final lstComments = <CommentModel>[];
    lstComments.add(
      CommentModel(
        type: CommentTypeEnum.text,
        viewType: CommentViewEnum.join,
        imageUrl: '',
        desc: '',
      ),
    );
    lstComments.add(
      CommentModel(
        type: CommentTypeEnum.text,
        viewType: CommentViewEnum.join,
        imageUrl: '',
        desc: '',
      ),
    );
    lstComments.add(
      CommentModel(
        type: CommentTypeEnum.text,
        viewType: CommentViewEnum.sender,
        imageUrl: '',
        desc: '',
      ),
    );
    lstComments.add(
      CommentModel(
        type: CommentTypeEnum.image,
        viewType: CommentViewEnum.receiver,
        imageUrl: '',
        desc: '',
      ),
    );
    lstComments.add(
      CommentModel(
        type: CommentTypeEnum.image,
        viewType: CommentViewEnum.sender,
        imageUrl: '',
        desc: '',
      ),
    );
    lstComments.add(
      CommentModel(
        type: CommentTypeEnum.text,
        viewType: CommentViewEnum.receiver,
        imageUrl: '',
        desc: '',
      ),
    );
    lstComments.add(
      CommentModel(
        type: CommentTypeEnum.text,
        viewType: CommentViewEnum.sender,
        imageUrl: '',
        desc: '',
      ),
    );
    lstComments.add(
      CommentModel(
        type: CommentTypeEnum.text,
        viewType: CommentViewEnum.receiver,
        imageUrl: '',
        desc: '',
      ),
    );

    state = state.copyWith(lstComments: lstComments);
  }

  void onSendTap(BuildContext context) {
    final commentText = commentController.text.trim();

    if (commentText.isEmpty) {
      alertMessage(errorMessage: S.current.commentAlert, context: context);
      return;
    }

    final lstData = state.lstComments.toList();
    lstData
        .add(CommentModel(type: CommentTypeEnum.text, viewType: CommentViewEnum.sender, desc: commentText));

    state = state.copyWith(lstComments: lstData);
    scrollToEnd();
    commentController.clear();
  }

  Future<void> onAttachmentTap() async {
    final imageSelected = await picker.pickImage(source: ImageSource.gallery);
    if (imageSelected != null) {}
  }

  //Scroll to End
  void scrollToEnd() {
    Future.delayed(Duration(milliseconds: durationMilliseconds), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    commentFocusNode.removeListener(onFocusChange);
    commentFocusNode.dispose();
    commentController.dispose();
    super.dispose();
  }
}
