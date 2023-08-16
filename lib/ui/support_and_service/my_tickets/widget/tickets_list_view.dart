import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/provider/my_tickets_provider.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/state/my_tickets_state.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_card.dart';

class TicketsListView extends StatelessWidget {
  const TicketsListView({
    required this.notifier,
    required this.provider,
    required this.lstData,
    super.key,
  });

  final MyTicketsNotifier notifier;
  final MyTicketsState provider;
  final List<SupportTicketModel> lstData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: notifier.scrollController,
      padding:
          EdgeInsets.only(right: 16.w, left: 16.w, bottom: 60.h, top: 10.h),
      itemBuilder: (_, index) {
        if (lstData.length == index) {
          return Center(
            child: SizedBox(
              height: 20.h,
              width: 20.w,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ).visibility(visible: provider.isLoading);
        }
        return TicketCard(
          ticketModel: lstData[index],
          index: index,
        );
      },
      separatorBuilder: (_, index) {
        return SizedBox(
          height: 15.h,
        );
      },
      itemCount: lstData.length + 1,
    );
  }
}
