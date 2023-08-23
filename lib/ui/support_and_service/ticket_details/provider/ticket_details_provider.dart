import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/support/model/attachment_response_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/ui/support_and_service/ticket_details/index.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

final ticketDetailsProvider = StateNotifierProvider.autoDispose<
    TicketDetailsNotifier, TicketDetailsState>((ref) {
  return TicketDetailsNotifier(ref: ref);
});

class TicketDetailsNotifier extends StateNotifier<TicketDetailsState> {
  TicketDetailsNotifier({required this.ref})
      : super(TicketDetailsState.initial()) {
    _initData();
  }

  final Ref ref;
  SupportTicketModel? ticketData;
  late AutoScrollController scrollController;
  late TextEditingController commentController;
  late FocusNode commentFocusNode;
  int durationMilliseconds = 400;
  final picker = ImagePicker();
  late int? userId;

  Future<void> _initData() async {
    scrollController = AutoScrollController();
    commentController = TextEditingController();
    commentFocusNode = FocusNode();

    commentFocusNode.addListener(onFocusChange);
    userId = await DixelsSDK.instance.userId;
  }

  void onFocusChange() {
    if (commentFocusNode.hasFocus) {
      scrollToEnd();
    }
  }

  Future<void> getCommentsData() async {
    final param = ParametersModel();
    param.filter = FilterUtils.filterBy(
      key: 'r_ticketComments_c_supportTicketId',
      value: "'${ticketData!.id}'",
      operator: FilterOperator.equal.value,
    );
    final result = await DixelsSDK.instance.ticketCommentsService
        .getPageData(fromJson: TicketCommentModel.fromJson, params: param);

    if (result != null && result.items!.isNotEmpty) {
      final lstData = result.items!.toList();
      lstData.insert(0, TicketCommentModel());
      state = state.copyWith(lstComments: lstData);
      scrollToEnd();
    } else {
      final lstData = <TicketCommentModel>[];
      lstData.insert(0, TicketCommentModel());
      state = state.copyWith(lstComments: lstData);
    }
  }

  Future<void> onSendTap(BuildContext context) async {
    final commentText = commentController.text.trim();

    if (commentText.isEmpty) {
      alertMessage(errorMessage: S.current.commentAlert, context: context);
      return;
    }

    final lstData = state.lstComments.toList();
    lstData.add(
      TicketCommentModel(
        commentDescription: commentText,
        dateCreated: DateTime.now(),
        creator: Creator(
          id: userId,
        ),
      ),
    );

    state = state.copyWith(lstComments: lstData);
    scrollToEnd();
    commentController.text = '';

    final request = {
      'commentDescription': commentText,
      'r_ticketComments_c_supportTicketId': ticketData?.id,
    };
    final result = await DixelsSDK.instance.ticketCommentsService.postPageData(
      reqModel: request,
      fromJson: TicketCommentModel.fromJson,
    );
    if (result != null) {}
  }

  Future<void> onAttachmentTap({required BuildContext context}) async {
    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
      final attachment = await uploadAttachmentAsync(
        fileName: response.name,
        filePath: response.path,
      );
      if (attachment != null) {
        final request = {
          'commentDescription': 'attachment',
          'commentAttachment': attachment.id,
          'r_ticketComments_c_supportTicketId': ticketData?.id
        };
        final result =
            await DixelsSDK.instance.ticketCommentsService.postPageData(
          reqModel: request,
          fromJson: TicketCommentModel.fromJson,
        );
        if (result != null) {
          final lstData = state.lstComments.toList();
          lstData.add(result);
          state = state.copyWith(lstComments: lstData);
          scrollToEnd();
        }
      }
    }
  }

  Future<AttachmentResponseModel?> uploadAttachmentAsync({
    required String fileName,
    required String filePath,
  }) async {
    return DixelsSDK.instance.supportService.uploadAttachmentAsync(
      fileName: fileName,
      filePath: filePath,
    );
  }

  //Scroll to End
  void scrollToEnd() {
    Future.delayed(Duration(milliseconds: durationMilliseconds), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void setScrollDown(bool value) {
    state = state.copyWith(isScrollDown: value);
  }

  @override
  void dispose() {
    commentFocusNode.removeListener(onFocusChange);
    commentFocusNode.dispose();
    commentController.dispose();
    super.dispose();
  }
}
