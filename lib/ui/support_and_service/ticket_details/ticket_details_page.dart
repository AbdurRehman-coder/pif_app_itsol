import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_status.dart';
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
      appBar: CustomAppBar(
        title: S.current.support,
        actionWidget: [
          if (widget.ticketData.ticketStatus != null) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.w,
                  ),
                  child: TicketStatus(
                    ticketStatus: widget.ticketData.ticketStatus!,
                    isFromAction: true,
                  ),
                ).visibility(visible: provider.isScrollDown!),
              ],
            ),
          ],
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h, top: 2.h),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification) {
                    final scrollPosition = notifier.scrollController.position;
                    // Calculate whether the user has scrolled down enough
                    final shouldShowActions = scrollPosition.pixels > 80.0;
                    // Only update if the value has changed
                    if (shouldShowActions != provider.isScrollDown) {
                      notifier.setScrollDown(shouldShowActions);
                    }
                  }
                  return true;
                },
                child: ListView.separated(
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

  Widget getCommentView(
    TicketCommentModel item,
    TicketDetailsNotifier notifier,
  ) {
    final viewType = item.creator?.id == notifier.userId
        ? CommentViewEnum.sender
        : CommentViewEnum.receiver;
    final type = item.commentAttachment != null
        ? CommentTypeEnum.image
        : CommentTypeEnum.text;

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
