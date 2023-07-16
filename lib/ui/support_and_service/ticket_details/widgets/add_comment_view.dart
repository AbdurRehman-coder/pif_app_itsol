import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/ticket_details/index.dart';

class AddCommentView extends StatelessWidget {
  const AddCommentView({required this.notifier, super.key});

  final TicketDetailsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(
                color: grayE3,
              ),
              color: whiteColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: notifier.commentController,
                    focusNode: notifier.commentFocusNode,
                    style: Style.commonTextStyle(
                      color: grayTextColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: Style.inputDecoration(
                      text: S.of(context).addComment,
                      hintColor: hintColor,
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.attachment,
                    color: hintColor,
                  ),
                  onPressed: () {
                    notifier.onAttachmentTap(context: context);
                  },
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        InkWell(
          onTap: () {
            notifier.onSendTap(context);
          },
          child: Container(
            height: 45.h,
            width: 45.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: greenBorderColor),
            ),
            child: const Icon(
              Icons.send,
              color: whiteColor,
            ),
          ),
        )
      ],
    ).visibility(visible: notifier.ticketData!.ticketStatus!.key != 'closed');
  }
}
