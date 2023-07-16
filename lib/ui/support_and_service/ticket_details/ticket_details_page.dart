import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/ticket_details/index.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class TicketDetailsPage extends ConsumerStatefulWidget {
  const TicketDetailsPage({required this.ticketData, super.key});

  final SupportTicketModel ticketData;

  @override
  ConsumerState createState() => _SupportDetailsPageState();
}

class _SupportDetailsPageState extends ConsumerState<TicketDetailsPage> {
  @override
  void initState() {
    super.initState();
    final notifier = ref.read(ticketDetailsProvider.notifier);
    notifier.ticketData = widget.ticketData;
    notifier.getCommentsData();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(ticketDetailsProvider.notifier);
    final provider = ref.watch(ticketDetailsProvider);
    return Scaffold(
      backgroundColor: expireBgColor,
      appBar: AppBar(
        backgroundColor: expireBgColor,
        elevation: 0,
        leading: InkWell(
          onTap: AppRouter.pop,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          S.current.support,
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView.separated(
                controller: notifier.scrollController,
                padding: EdgeInsets.only(bottom: 60.h),
                itemBuilder: (_, index) {
                  final item = provider.lstComments[index];
                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: notifier.scrollController,
                    index: index,
                    child: index == 0
                        ? TicketDetailsCard(ticketData: widget.ticketData)
                        : getCommentView(item, notifier),
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: 16.h,
                  );
                },
                itemCount: provider.lstComments.length,
              ),
              AddCommentView(
                notifier: notifier,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCommentView(TicketCommentModel item, TicketDetailsNotifier notifier) {
    final viewType = item.creator?.id == notifier.userId ? CommentViewEnum.sender : CommentViewEnum.receiver;
    final type = item.commentAttachment != null ? CommentTypeEnum.image : CommentTypeEnum.text;

    if (viewType == CommentViewEnum.sender) {
      if (type == CommentTypeEnum.text) {
        return SendTextView(
          item: item,
        );
      } else if (type == CommentTypeEnum.image) {
        return SenderImageView(
          item: item,
        );
      } else if (type == CommentTypeEnum.video) {
        return const SenderVideoView();
      }
    } else if (viewType == CommentViewEnum.receiver) {
      if (type == CommentTypeEnum.text) {
        return ReceiverTextView(
          item: item,
        );
      } else if (type == CommentTypeEnum.image) {
        return ReceiverImageView(item: item);
      } else if (type == CommentTypeEnum.video) {
        return const ReceiverVideoView();
      }
    } else {
      return const PersonJoinView();
    }
    return const SizedBox();
  }
}
