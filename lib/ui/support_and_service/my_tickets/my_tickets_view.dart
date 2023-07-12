import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/provider/my_tickets_provider.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/empty_ticket_view.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_card.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_list_status.dart';

class MyTicketsView extends ConsumerStatefulWidget {
  const MyTicketsView({
    super.key,
  });

  @override
  ConsumerState createState() => _MyTicketsViewState();
}

class _MyTicketsViewState extends ConsumerState<MyTicketsView> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(myTicketsProvider);
    final notifier = ref.read(myTicketsProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: expireBgColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: InkWell(
            onTap: AppRouter.pop,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 22,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SearchTextField(
            textEditingController: notifier.searchController,
            hintText: S.current.searchByDescription,
            onChanged: (textSearch) =>notifier.onSearchTicket(),
          ),
        ),
        titleSpacing: 0,
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.mirror,
            colors: [
              expireBgColor,
              expireBgColor,
              expireBgColor,
              gray98.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              if (notifier.searchController.text.isEmpty) ...[
                TicketListStatus(
                  notifier: notifier,
                  provider: provider,
                ),
              ],
              if (provider.ticketListSelect.isNotEmpty) ...[
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: notifier.getMyTickets,
                    child: ListView.separated(
                      padding:
                      EdgeInsets.only(right: 16.w,left: 16.w,bottom: 60.h,top: 10.h),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final myTickets = provider.ticketListSelect[index];
                        return TicketCard(
                          ticketModel: myTickets,
                          index: index,
                        );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(height: 15.h);
                      },
                      itemCount: provider.myTicketList.isLoading
                          ? 3
                          : provider.ticketListSelect.length,
                    ).shimmerLoading(
                      loading: provider.myTicketList.isLoading,
                    ),
                  ),
                ),
              ] else
                ...[
                  const EmptyTicketView(),
                ],
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => AppRouter.pushNamed(Routes.addOrEditTicketScreen),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 21.w),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(35.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.forum,
                    colorFilter: const ColorFilter.mode(
                      whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    S.current.getSupport,
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
